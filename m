Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA17E4A9B80
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 15:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiBDOxL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 09:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBDOxL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 09:53:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27203C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 06:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=brt2xN3zDL9LEnNizoLM7NpZqLSnwTMeL8/ygCgPArE=;
        t=1643986391; x=1645195991; b=Y/QUyaV6rVMNPRLTW5gv7M+BqdiphkX+619GB9M1i9MMNnY
        jLUiIsSTouTIDY8LUdPeqLuXqnPdphsI/jq5/K5ACP3w7uPnAt7jVqdYJuvD587x3ExhIQ+NrvVaV
        szxXu2G98zMOFBHSyd6wOTgVWj51hTxwCRqE2oOZDUrAnFhg0xH4BvRmJ3gN4t3gW4aOQMudbm41K
        DvHoVJgwcoyBe0xTj91HTxi0f+sbertBf5U7heQBujyHxR5woGoqmHlQVSFB69PrFVDWqy3e6NL8w
        BkuI91dXPfMogot50DvZFa/RkqzZkKutQnc05WnQ/D4vgjIGQTaLkruZ8A02CGVg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nFzxV-00EW9S-HT;
        Fri, 04 Feb 2022 15:53:09 +0100
Message-ID: <b34e27d8d3c373501cd4994ec3583971733f7bbf.camel@sipsolutions.net>
Subject: Re: [PATCH 6/6] nl80211: add EHT MCS support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, quic_vikram@quicinc.com,
        quic_alokad@quicinc.com, quic_jiad@quicinc.com,
        quic_periyasa@quicinc.com, quic_msinada@quicinc.com,
        quic_srirrama@quicinc.com
Date:   Fri, 04 Feb 2022 15:53:08 +0100
In-Reply-To: <1640163883-12696-7-git-send-email-quic_vjakkam@quicinc.com>
References: <1640163883-12696-1-git-send-email-quic_vjakkam@quicinc.com>
         <1640163883-12696-7-git-send-email-quic_vjakkam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-12-22 at 14:34 +0530, Veerendranath Jakkam wrote:
> 
> + * @NL80211_RATE_INFO_EHT_NSS: EHT NSS value (u8, 1-8)
> 

I'll note you also put 1-8 here ;-)

johannes
