Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8C4D00E0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbiCGOQz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 09:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbiCGOQz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 09:16:55 -0500
Received: from titan58.planetwebservers.net (titan58.planetwebservers.net [51.79.1.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CA871CBF
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 06:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
        References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TN9iMA1fzigajsNWbugsfxu1dY9qbouPWphbIzOuHj0=; b=jPKTgRptaNW/oUVf/dHVZy8Ct6
        vmIcuIogtDVtJxjUHSyUBUtJ0JeVgOSROCJeYwDb3Ggg6TtEyQR59v3jT6CYOl7Sa8b/dwHdlg9TA
        mGJt77ev6CKtBkBkM7VIs/U2xF1ByxkvwgdZ4qAQbevcZC7Pj0Hm9xj7B98xSfVBIVnIEXvlI59b2
        U6vnzCDYGu7ysRXCVCdFXNuFutDYuPI3AkfjjXHICDoQUf8c1dNuzrKcG/JB85LrTIv+x7v4nluT4
        mlFMy/VmWZBtCJuN+6MnYteoq1MOE1TRDfza3OR9iPjDL6ZEYHtAMAgFSFxfAdVq4ZDep8ABE4lvA
        tuakyfxg==;
Received: from [37.19.213.113] (port=37671 helo=dummy.faircode.eu)
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1nRE9W-0006B5-3i; Tue, 08 Mar 2022 01:15:57 +1100
Date:   Mon, 7 Mar 2022 14:15:55 +0000 (UTC)
From:   James <bjlockie@lockie.ca>
To:     Riccardo Paolo Bestetti <pbl@bestov.io>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <59a1cd3d-46a1-4442-9cec-380044fa0790@lockie.ca>
In-Reply-To: <CICSX6EXTZ6U.MYGFTUDU5ZKW@enhorning>
References:  <CICSX6EXTZ6U.MYGFTUDU5ZKW@enhorning>
Subject: Re: MK7921K de-auths from AP every 5 minutes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <59a1cd3d-46a1-4442-9cec-380044fa0790@lockie.ca>
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

You could try a different channel?
Is it 2.4 or 5GHz?
