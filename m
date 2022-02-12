Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEB74B3829
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 22:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiBLVKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 16:10:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiBLVKR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 16:10:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA0606F4
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PBtf4rPsa5e+Qn5Lx97LOIpX0MjdfeHnl6+s5vBIPaM=;
        t=1644700213; x=1645909813; b=iitebB+zBhquD8KQoTIZuh8CGv+w8GTAZlkL4vWNZL07LPE
        4dZWYuJrles+sW6jTAqJXNMTTCf+4lqS1HJ9TBCoYjpdrRCLuVsbhZD7ZmvoVw7mX4g8sUX0yeozp
        QNQAX0xqVYWOL6U7I+3yZP0PYsrl4whzjA91LnyxWicvVMFAI8H/ALRkqbIsjubcD1PscUTTD55RF
        PNzd4XlT8SJOEVPEdTKgxjE5vnh7ZGKU3Ggc3Igt++S6hDasqGQq6CJsH9RIXvS9BobxGbwNrAAs1
        sC8MHPEw1RH8Ne3kmlvTRaTysXDMJiJVSE1PUwj3MaoN10iHnd94tooxWinRUP4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nIzeh-000Mmp-3n;
        Sat, 12 Feb 2022 22:10:07 +0100
Message-ID: <6d87acca10648841b60e2a28a46a328340bf939a.camel@sipsolutions.net>
Subject: Re: [PATCH 1/6] nl80211: vendor-cmd: qca: add command for CFR
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Feb 2022 22:10:06 +0100
In-Reply-To: <1644592075-27082-2-git-send-email-quic_vnaralas@quicinc.com>
References: <1644592075-27082-1-git-send-email-quic_vnaralas@quicinc.com>
         <1644592075-27082-2-git-send-email-quic_vnaralas@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2022-02-11 at 20:37 +0530, Venkateswara Naralasetty wrote:
> This patch is to add vendor command support to configure per
> peer CFR parameters.
> 

That's pretty much the worst way to start this ...

Please explain at least what CFR is? What does the feature do?

And please also see
https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

johannes
