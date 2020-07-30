Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF42023311F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 13:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgG3LpY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 07:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgG3LpY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 07:45:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264D7C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 04:45:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k16zv-00DV0r-SG; Thu, 30 Jul 2020 13:45:19 +0200
Message-ID: <9271c24316853ac90dd466357ad5845dcc9891c9.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: vendor-cmd: qca: add command for ap power
 save
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Venkateswara Naralasetty <vnaralas@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 13:45:19 +0200
In-Reply-To: <1589954745-12870-1-git-send-email-vnaralas@codeaurora.org> (sfid-20200520_080604_936685_6A1D30A3)
References: <1589954745-12870-1-git-send-email-vnaralas@codeaurora.org>
         (sfid-20200520_080604_936685_6A1D30A3)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-20 at 11:35 +0530, Venkateswara Naralasetty wrote:
> This patch is to add vendor command support to enable/disable
> ap power save.
> 
> An example of usage: iw dev wlanx vendor send 0x1374 0x4a ap-ps <val>
> 
> 0x1374: vendor id
> 0x4a: vendor subcmd id
> val: 0 - disable power save
>      1 - enable power save

This really doesn't pass the bar ...

https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

johannes

