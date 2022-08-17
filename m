Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD2A597A8A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 02:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiHRAQM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 20:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiHRAQL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 20:16:11 -0400
X-Greylist: delayed 3277 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Aug 2022 17:16:10 PDT
Received: from titan5.planetwebservers.net (titan5.planetwebservers.net [51.222.33.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34074A4B1D
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
        References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Zf7qbe1AmOmVv1fL9vi4vy/M0xvDubsm9tTwetFlvZs=; b=Y0mdTg6fek9UhM04B1WMo899XO
        ml1+wheW/ajfoS7uaXsMqPu4NE6hoWQazS5SzzrRtrsEVMuAqpnVsXnhoHsHb3iqHLeIS6lmDWt9H
        lSl9DnqkyKAsKDR3SNaoflIYq1obUdPTS9eSiu+S2ORsnrTCYpivg+Wfn2YmWe17abZ2IICC/tLEi
        JseKx6LgVLJ1dWfv5RSB8lfqOXF+oQZh4gcC59WAoFGvf1qZB/wKKKjrsqsdSKwjeSnpNdEF8qcJs
        Oa+XxgKfKOmRrfpvJqSeRm3tnrSnIKkVnk7Pc6UMLv+YFhXWpH5XflvAegi9JzsD7DhqOw6SEOQ0x
        +dXOO1HA==;
Received: from [76.75.115.213] (port=46978 helo=dummy.faircode.eu)
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <bjlockie@lockie.ca>)
        id 1oOSLn-0000HC-Ov;
        Thu, 18 Aug 2022 09:21:32 +1000
Date:   Wed, 17 Aug 2022 23:21:23 +0000 (UTC)
From:   James <bjlockie@lockie.ca>
To:     Agus Isas <isasmendi.agus@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <bd413a69-2b8f-4639-bb4e-0fe2b3a256ab@lockie.ca>
In-Reply-To: <CAE95GxXXq_-H0jmwiV5YMNFQCfE8feG0sPeLw_P50Zn9D7Yq6Q@mail.gmail.com>
References:  <CAE95GxXXq_-H0jmwiV5YMNFQCfE8feG0sPeLw_P50Zn9D7Yq6Q@mail.gmail.com>
Subject: Re: [ RTW88 driver ] - P2P support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <bd413a69-2b8f-4639-bb4e-0fe2b3a256ab@lockie.ca>
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
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> I am reaching out to you to ask for any roadmap or intentions to add
> P2P support to the RTW88 driver

I have no idea if the in kernel driver will support wifi direct.

The out of kernel driver might.
Read the comments for this:
https://askubuntu.com/questions/1167581/p2p-on-rtl8812au-not-working
