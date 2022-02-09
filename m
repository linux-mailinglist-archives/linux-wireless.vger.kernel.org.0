Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6B04B00F6
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 00:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiBIXJu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 18:09:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiBIXJs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 18:09:48 -0500
X-Greylist: delayed 1294 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 15:09:50 PST
Received: from titan58.planetwebservers.net (titan58.planetwebservers.net [51.79.1.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA69FC1038D3
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 15:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
        References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uuYy3pgBLJlp1jG7KCw60ePICm6Xrboto80HtFur3pw=; b=QUy1mvb4Y2ANeE3V1TmMZjqVbA
        Bt2yME1ldBxSy21GnchHPpx7UDfVX1D5Ir7WaWwwQFWnCWKfd45p2ugOV80yts0tubVfNtSCyBoCA
        wqp5n52ASWVHB69tRrQFpeN6EOiJROdgW/44ErEmfbE5H2N9N8G4fWCJzpdZ2N6rgJyAWCa+z9RIO
        iIg/NKC9RySf1BZe3j4ztVEOaFZWIumnjWE9JSM97uKbguJlnSwEn+QGqtjQbvUrx2soBwkKoCbOy
        rDIwGC6Ap53BGsCrqpXXDucMT6I+DXGv3Q+B+KxIzODcumzuqbYp0Vr6u3KqsNEASYIADj7XESpZW
        OrN7yqvA==;
Received: from [37.19.212.114] (port=40973 helo=dummy.faircode.eu)
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1nHvl4-00018d-Lx; Thu, 10 Feb 2022 09:48:15 +1100
Date:   Wed, 9 Feb 2022 22:48:12 +0000 (UTC)
From:   James <bjlockie@lockie.ca>
To:     =?UTF-8?Q?Gabriel_F=C3=A9ron?= <g@leirbag.net>
Cc:     Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <ffa205c1-710b-44a3-8c05-7a53767472fd@lockie.ca>
In-Reply-To: <MvV0sOB--3-2@leirbag.net>
References:  <MvV0sOB--3-2@leirbag.net>
Subject: Re: Disconnection every 10 minutes with mt7921e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <ffa205c1-710b-44a3-8c05-7a53767472fd@lockie.ca>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I also get disconnected (by AP) reason: 2: Previous authentication no longer valid but on an Intel ax200 (built in my Intel laptop) but networkmanager reconnects.
I wonder if it is problem with the infrastructure.
