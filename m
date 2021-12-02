Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F460465D42
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Dec 2021 05:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352368AbhLBETK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Dec 2021 23:19:10 -0500
Received: from titan58.planetwebservers.net ([51.79.1.102]:54975 "EHLO
        titan58.planetwebservers.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344656AbhLBES7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Dec 2021 23:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
        References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=m1S+DkRftQkAXvLRZe78SZSsX+Q9ze5AJ2O2D1obcZg=; b=vJLalqSqZ52qpRoqlwDSVdq6Gm
        jws6/e3jRrxDdkMi7141snOVguTH0yEaI4BSzXQyZvI8G3t1sm6W8tr95YFDNT01Nou1KJO+YTud2
        yACGaq3zfkpCOErYWdifZECJRgAIWxVYb0cUQs3MDSL7TES4sW7tNfq0HAGntBtHU1GtLhPWA9g9c
        GFqKyUrRBsxUhy3FjI4k7C7J8bMycme0yHheT0KIBW8EZTAeKX6wEiAXlcPBPvMJ0RtjUiycYMrzT
        QztVidtDk1Peg2ePkCV6X9YToUyHqJJ+CvpSLSFlTNP0GKNujd+aid+zvZ3O/Iss4sU0Qc8WpeyCH
        FXfTzgmQ==;
Received: from [98.124.54.9] (port=44948 helo=dummy.faircode.eu)
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1msdVQ-0002hZ-65; Thu, 02 Dec 2021 15:15:33 +1100
Date:   Thu, 2 Dec 2021 04:15:33 +0000 (UTC)
From:   James <bjlockie@lockie.ca>
To:     Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <acc80379-4e2b-4bf4-a5ae-728081d53bfb@lockie.ca>
In-Reply-To: <3b1b8fd6e21c43f3ad7ce9d455db00a0@realtek.com>
References: <789b4af2-9853-031b-72e2-962174620116@lockie.ca> <3b1b8fd6e21c43f3ad7ce9d455db00a0@realtek.com>
Subject: RE: Realtek naming
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <acc80379-4e2b-4bf4-a5ae-728081d53bfb@lockie.ca>
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
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

.
> The 8852Bx is another (next) series of 802.11AX chip whose hardware capabilities
> are different from 8852Ax.
Will the rtw89 driver support the 8852Bx+?
