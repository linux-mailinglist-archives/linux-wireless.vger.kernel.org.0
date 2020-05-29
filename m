Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0C1E7D84
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 14:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgE2Mqb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 08:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Mqb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 08:46:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1466DC03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 05:46:31 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeeP4-005Vtm-NY; Fri, 29 May 2020 14:46:26 +0200
Message-ID: <f2b8fb0783b270a177ee900168fdc1fbc9253e3d.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: enable TKIP when using encapsulation
 offloading
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 14:46:25 +0200
In-Reply-To: <4bab3197997bb2dd6555ff920c5dd1cb@codeaurora.org>
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
         <1587720951-9222-2-git-send-email-murugana@codeaurora.org>
         (sfid-20200424_113624_468114_4CC488DE) <d4e39180f0a8a8b07dc558c9439b66cd2c3aec07.camel@sipsolutions.net>
         <7fb606edf1e5c7ab5b1446d637768ee7@codeaurora.org>
         <aaa53c3a9cf6788cb653eb574073a1a0bcc5e6bf.camel@sipsolutions.net>
         <4bab3197997bb2dd6555ff920c5dd1cb@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-05-29 at 17:59 +0530, Sathishkumar Muruganandam wrote:
> 
> Yes, currently only tx encap support is added and rx decap support is in
> progress to do TKIP MIC error reporting to userspace via 
> cfg80211_michael_mic_failure().

Yes, but can you actually call that? It requires a netdev. I don't think
you can easily get it from the vif?

johannes

