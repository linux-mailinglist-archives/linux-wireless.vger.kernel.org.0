Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055FB149C1C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 18:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgAZRct (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 12:32:49 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:53432 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgAZRct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 12:32:49 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ivlmB-007mL1-6l; Sun, 26 Jan 2020 18:32:47 +0100
Message-ID: <5290eda7dee50997e7fa5bb5976256b024f7e94e.camel@sipsolutions.net>
Subject: Re: [PATCH v3] cfg80211: Enhance the AKM advertizement to support
 per interface.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <vjakkam@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 26 Jan 2020 18:32:45 +0100
In-Reply-To: <20200126112113.19542-1-vjakkam@codeaurora.org>
References: <20200117113507.13503-1-vjakkam@codeaurora.org>
         <20200126112113.19542-1-vjakkam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-01-26 at 16:51 +0530, Veerendranath Jakkam wrote:
> 
> +
> +	nested = nla_nest_start(msg, NL80211_ATTR_IFTYPE_AKM_SUITES);
> +	if (!nested)
> +		return -ENOBUFS;
> +
> +	for (i = 0; i < rdev->wiphy.num_iftype_akm_suites; i++) {
> +		nested_akms = nla_nest_start(msg, i + 1);
> +		if (!nested_akms)
> +			return -ENOBUFS;
> +
> +		iftype_akms = &rdev->wiphy.iftype_akm_suites[i];
> +
> +		if (nl80211_put_iftypes(msg, NL80211_ATTR_SUPPORTED_IFTYPES,
> +					iftype_akms->iftypes_mask))
> +			return -ENOBUFS;
> +
> +		if (nla_put(msg, NL80211_ATTR_AKM_SUITES,

Using the top-level attributes inside the nesting makes things
unnecessarily difficult to understand and take far more memory to parse,
IMHO it'd be better to define a new set of inner attributes
NL80211_IFTYPE_AKM_ATTR_IFTYPES, ..._SUITES or so.

johannes

