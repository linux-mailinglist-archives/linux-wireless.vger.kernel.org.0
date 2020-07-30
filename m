Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80947233298
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgG3NGS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3NGR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:06:17 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD5C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:06:16 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18GE-00DXLG-8k; Thu, 30 Jul 2020 15:06:15 +0200
Message-ID: <b454115ff41f6b52cb511a21dc093e8ce4d72ee2.camel@sipsolutions.net>
Subject: Re: [PATCH V2 05/10] mac80211: propagate multi bssid settings when
 starting
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 30 Jul 2020 15:06:13 +0200
In-Reply-To: <20200706115219.663650-5-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
         <20200706115219.663650-5-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-07-06 at 13:52 +0200, John Crispin wrote:
> 
> +	memcpy(&sdata->vif.bss_conf.multi_bssid, &params->multi_bssid,
> +	       sizeof(struct ieee80211_multi_bssid));

What's wrong with struct assignments? :)

	sdata->vif.bss_conf.multi_bssid = params->multi_bssid;

works just fine ...

johannes

