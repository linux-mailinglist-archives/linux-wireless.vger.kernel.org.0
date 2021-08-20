Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC693F2A20
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhHTK3h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 06:29:37 -0400
Received: from lpdvsmtp10.broadcom.com ([192.19.11.229]:33538 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239083AbhHTK3g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 06:29:36 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0E2BD22593;
        Fri, 20 Aug 2021 03:28:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0E2BD22593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1629455338;
        bh=7KgjndPq46IQLemIhu2ODSAsGBR2U7KWwrBj3h/zoz0=;
        h=To:From:Subject:Cc:Date:From;
        b=qEsbMX9EBGC5TlkNqlEPLbDEIRSKUPYnGafz+DnXBobc+C4QoYAldhfG9GoCx9XRY
         7AUYvE8VxrUwmZNlpXxV2frlQBkPc3MY1OIRLtN4LiMr12YSp2Q8mHficuEjoAcKxi
         Ti7KDBZFjd08WJoVRSRX0JxYoeVXUR4fCwr4vGew=
Received: from [10.176.51.53] (d581793.dhcp.broadcom.net [10.176.51.53])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 54F051874BD;
        Fri, 20 Aug 2021 03:28:57 -0700 (PDT)
To:     Kalle Valo <kvalo@codeaurora.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: brcmfmac patch serie
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <94b84496-a072-4dd5-a11e-01b10dfe2170@broadcom.com>
Date:   Fri, 20 Aug 2021 12:28:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

I posted a patch series last month, but it is still marked as 'New' in 
patchwork. Any chance to get that in? It still applies to 
wireless-drivers-next/master (just checked).

Here the URL for this series:

https://patchwork.kernel.org/project/linux-wireless/list/?series=522927

Regards,
Arend
