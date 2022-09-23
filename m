Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079EF5E86A8
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 02:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiIXAS4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 20:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbiIXAS1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 20:18:27 -0400
X-Greylist: delayed 3557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 17:18:24 PDT
Received: from titan5.planetwebservers.net (titan5.planetwebservers.net [51.222.33.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A151231D6
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 17:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:Subject:To:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F67YboFp9pgYKV4RC0SazZS4byPbxPnCd0zMKrmZ+YA=; b=v8zLdtfEK47MwC+YcUsE3VDbBS
        yfF0zN5Ozvhx+GyrnD5LeDNrQT7KdcY3IXj6jSMz2+2acH6OHAJARf/cn8r03ArV8i9ye3fHiMMMt
        Nm0DKVE9rl9dD/g7C0fPdALSlAUIjuXXc6SAfMiEjG5c2CWGdc9dCOAmPyLa276tIME7LRwRhVhfK
        DL/Gypays24ksd8oBzKENlFSXi5RiF+MqCcB0n1nXYH1Tf+mvP5x7pNUwIC64rleDioc/thfSPmy8
        4KP9iXcI8B9G2kxHnXnk8+V8jB66ILhCmwCKb5DSUoaqdzXXKjHcRmVuc/L1X1d54Vh5HKhqeTxXl
        vY16SJHQ==;
Received: from [76.75.115.213] (port=51856 helo=[192.168.68.80])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <bjlockie@lockie.ca>)
        id 1obrwj-0004Ah-R6
        for linux-wireless@vger.kernel.org;
        Sat, 24 Sep 2022 09:19:06 +1000
Message-ID: <71575c7b-8487-3b12-fe33-3e5e8b2ff9a2@lockie.ca>
Date:   Fri, 23 Sep 2022 19:18:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
To:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: what MediaTek chipset do I have?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I bought a MediaTek PCI card on Amazon that is supposed to be a 7921k chip.
I don't have a 6GHz router and the seller says if I did then it will 
work in 6GHz.
The Windows driver is for an AMD RZ608 Wi-Fi 6E 80MHz but the properties 
there don't say 6GHz.
The seller says I can't see 6GHz there unless I have a 6GHz router.
I don't believe that  but you guys know better.
I bought it for Linux. :-)
The only reason I mention Windows is because that is the seller's language.

Here is Linux info:
5.15.0-48-generic #54-Ubuntu SMP x86_64

# lspci -k
04:00.0 Network controller: MEDIATEK Corp. Device 0608
         Subsystem: MEDIATEK Corp. Device 0608
         Kernel driver in use: mt7921e
         Kernel modules: mt7921e

Would I say 7921k if it was?
