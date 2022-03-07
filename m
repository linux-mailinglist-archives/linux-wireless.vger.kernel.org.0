Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34A44D019C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 15:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbiCGOnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 09:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiCGOnI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 09:43:08 -0500
Received: from titan58.planetwebservers.net (titan58.planetwebservers.net [51.79.1.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170146D4F9
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
        References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mRIESI+6inztVmBAjYx81Z3VVCC3Ue7bfAuWdPga/Ig=; b=QF6jF6EDU5QNpBR+1sQ2MLMxXb
        KLukKKfACTU89LAsrsRzSFl7n+Ls7XL5XvK+cpNypGhGhNlMi8egZvYQ4pSqA6kQTdlwP7RSR+U50
        U7ggTi0yvvxujeUtKtbSQTfQSojyPe/2SP+2qACakW6BGQC/REaXI0rWFiPE5KZW4sCOMmh6vicJ9
        74AOVDuHKNXNek1g3k6an1rBuUhJxhcLujRMuMIkrDDz8VwQyeyArjIrjgwSSh+BhlXjXz0zVc+lK
        lOateBtZ16dSGSAzwxh0F2eyQrpx0diWzC3bJTYl9GwdL2A4Y+sX5J4TIba/5L0WLu5R9Y6dpUymx
        Pp0zRN9Q==;
Received: from [37.19.213.113] (port=38025 helo=dummy.faircode.eu)
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1nREYw-0001zY-Jl; Tue, 08 Mar 2022 01:42:13 +1100
Date:   Mon, 7 Mar 2022 14:42:12 +0000 (UTC)
From:   James <bjlockie@lockie.ca>
To:     Riccardo Paolo Bestetti <pbl@bestov.io>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <1666def0-7cdd-4685-af62-f8df8b02ed21@lockie.ca>
In-Reply-To: <CIDPF6OMQ0MJ.10W2JI66K5FM1@enhorning>
References: <CICSX6EXTZ6U.MYGFTUDU5ZKW@enhorning> <59a1cd3d-46a1-4442-9cec-380044fa0790@lockie.ca> <CIDPF6OMQ0MJ.10W2JI66K5FM1@enhorning>
Subject: Re: MK7921K de-auths from AP every 5 minutes
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <1666def0-7cdd-4685-af62-f8df8b02ed21@lockie.ca>
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

Can you try a rc kernel?
