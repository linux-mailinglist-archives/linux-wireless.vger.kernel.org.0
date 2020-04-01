Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB3E19A5FB
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 09:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbgDAHMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 03:12:22 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33608 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgDAHMW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 03:12:22 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jJXXx-00BTsu-3s; Wed, 01 Apr 2020 09:12:21 +0200
Message-ID: <4c7937c50320ef5b0a5bb70a924aba741652ac77.camel@sipsolutions.net>
Subject: Re: [RFC 6/7] nl80211: add KHz frequency offset for most wifi
 commands
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 01 Apr 2020 09:12:18 +0200
In-Reply-To: <20200401062150.3324-7-thomas@adapt-ip.com>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
         <20200401062150.3324-7-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:
> 
> +	[NL80211_ATTR_CENTER_FREQ1_OFFSET] = { .type = NLA_U32 },

These should probably all be something like

	NLA_POLICY_RANGE(NLA_U32, 0, 999)?

johannes


