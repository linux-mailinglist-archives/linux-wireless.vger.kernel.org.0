Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA9213C3F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2020 17:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgGCPDB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jul 2020 11:03:01 -0400
Received: from mon2.sibername.com ([162.144.51.228]:40667 "EHLO
        mon1.sibername.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbgGCPDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jul 2020 11:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gYXY2zp55r8/FzUZuP8oRZ+OLJWcd8P0gu5APIHsrzQ=; b=FOxzo6y9PGsejiNUmyVHrJoPZd
        JEYeR19lW6rAE5QTY5pegJkZrGCngJ8u4wVRZEd7qa8xXx092ozt2yF37fuuzoQKHK0qfUlpAva4X
        bRKNx1Rqg+Kl5nAEDQxarUOZEIZ0TItTdtRRS59XR1k9NcCK3dQAFZTzpsmMqLcPQo8m9vV2VSFSv
        hGEYwwPsfoP07IRncaNSupoCajpWLVeZMvbPRW+4Zo7Bqv1J+X7IjVBT6lHKXPvCHPQX26uQik/Ei
        nuMMct//TulDH1uDT7lAiBinH2sByCJaLzfD22E+qF6UbuRfz778PrQkYvxXXf++09WfPvFhe73jo
        9vLcTEGg==;
Received: from 216-58-17-101.cpe.distributel.net ([216.58.17.101]:39498 helo=[192.168.1.4])
        by montreal.sibername.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bjlockie@lockie.ca>)
        id 1jrNDA-001neA-My
        for linux-wireless@vger.kernel.org; Fri, 03 Jul 2020 11:02:58 -0400
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   James <bjlockie@lockie.ca>
Subject: mt76x2u 2-1.4:1.0: vendor request req:07 off:1114 failed:-71
Message-ID: <40e2203b-7ab9-f8a0-c9d4-8f9fffc22b24@lockie.ca>
Date:   Fri, 3 Jul 2020 11:02:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=1.5
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - montreal.sibername.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: montreal.sibername.com: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: montreal.sibername.com: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


My AP died after 3 days.
It looked promising with disable_usb_sg but then had a new error:

Fri Jul 3 10:19:23 2020 kern.err kernel: [324603.909608] mt76x2u 
2-1.4:1.0: vendor request req:07 off:1114 failed:-71

What does this one mean?
