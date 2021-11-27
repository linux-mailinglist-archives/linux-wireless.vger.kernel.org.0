Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9605546022E
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Nov 2021 23:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhK0Wxl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Nov 2021 17:53:41 -0500
Received: from titan58.planetwebservers.net ([51.79.1.102]:55817 "EHLO
        titan58.planetwebservers.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240002AbhK0Wvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Nov 2021 17:51:40 -0500
X-Greylist: delayed 1548 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Nov 2021 17:51:40 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cjcwm3TfpZCzXN+nQ2OHuCZwCXdnrUqYGPEnVd49QjY=; b=YRY9kg5ELfDiYtw4EHOPm7DWTn
        jDXLQ/JQ+SFTM4coNOSeObaFib+eqoCm2Q/oo8DgW7Js+7c7TUJVGaY27PqRzgctAQxS6QYKuBsL2
        fTUkNQLRiBziXiGJFylBBPv39F/g57gNL+2o1t/8Us1PmU7cBx1QI8bUBXOfNo2mmyo2SIhL3DYoB
        VYRs8pjytYXmme7KHwyme89vgbmss0P5vEqrzyIe2EStnTXCh3pY+UpaynVf8wgPMJOMofq7X07OX
        oin6eSE2h87dwR+lwsvrsxAvE48iDSKPvzsBGGcbNbY8lQbgkyHc5YAZrGGQwJy3cfo6oXPxF1oLD
        hpoFwLCw==;
Received: from [98.124.54.9] (port=45336 helo=[192.168.68.65])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1mr65b-0008Rc-10
        for linux-wireless@vger.kernel.org; Sun, 28 Nov 2021 09:22:36 +1100
Message-ID: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca>
Date:   Sat, 27 Nov 2021 17:22:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
To:     linux-wireless@vger.kernel.org
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
Subject: USB for rtw89 driver?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Are there any plans to support the USB interface with this driver?
Specifically for the DLink DWA-X1850 and other wifi6 USB devices based 
on this chipset?

Also,
Does anyone know if the proprietary driver works on the Raspberry Pi4B 
(Arm)?
