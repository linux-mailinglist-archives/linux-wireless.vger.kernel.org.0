Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9BF4E427B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Mar 2022 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiCVPF4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Mar 2022 11:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiCVPFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Mar 2022 11:05:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A01180224
        for <linux-wireless@vger.kernel.org>; Tue, 22 Mar 2022 08:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HzJWqJffoHTfJ5iJdRWHRzvNFUKMdQZHExGFGT/Q/l4=;
        t=1647961467; x=1649171067; b=VAKJDMrW1LbwYg+QNBx+7uUjTu5cb1f8ig3G8uj1B1sURZ2
        4OTCE47V2AbjcE/1ivw+1AiXzkCVIA4/4a4CMECns3MidfzRnoLsB7R8TdkANZgIJ15eiYIhWjNGw
        C1WAX5mMlCeSci5NJRfDU1m6Cn7wRegSAN3R/n1UXs2xQBY51ZaHHIisdVoyk/5Z9EQDP+RR3qXRt
        pue5s5k4fIaf68rhvweBcWQV4uaTzpCI0Pn4u3sVQGDCbEdDIHzkOanixK9QPlftK4Rvf0rwvO5rw
        vm6yTxSabN2Gxrs9trebkHlXxA0t9OIOBZ1HE2nGfudoxUvZw38FRTvQzXL23H4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nWg3a-00GfVI-C1;
        Tue, 22 Mar 2022 16:04:22 +0100
Message-ID: <babc75d310031f9f92736d5da65679ca50542849.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Date:   Tue, 22 Mar 2022 16:04:21 +0100
In-Reply-To: <DM6PR02MB493734ADBBC6C996845B9EF3E9179@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
         <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
         <a517835c51a5eaf00e87fdaaef47546f70ff0d42.camel@sipsolutions.net>
         <DM6PR02MB4937C53041172E9A52846A0BE9169@DM6PR02MB4937.namprd02.prod.outlook.com>
         <a537c6e02afbfa26eec2a54dbd8bc649f77ae3a3.camel@sipsolutions.net>
         <DM6PR02MB493734ADBBC6C996845B9EF3E9179@DM6PR02MB4937.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
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

On Tue, 2022-03-22 at 13:50 +0000, Rameshkumar Sundaram (QUIC) wrote:
> > 
> So, Suggestion here is to add a new NL attribute to carry the
> information from user space for
> START_AP and SET_BEACON NL commands and use it here, is that
> understanding correct ?
> 

Well, I was thinking it would reasonably come with the beacon rate, i.e.
as a new attribute like NL80211_TXRATE_DUP?

johannes
