Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A784461855
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 15:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377937AbhK2Oav (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 09:30:51 -0500
Received: from titan58.planetwebservers.net ([51.79.1.102]:37895 "EHLO
        titan58.planetwebservers.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233810AbhK2O2M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 09:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
        References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SdHGsdHPju0auK467ZsIg0yHr1MlV/cLP9xty2rj5Gw=; b=kdDSPVnxOi+sasrVGuJYZDBwnI
        D3Z8mSrieisYNR+EjMY4XMfHeUQT5Pr3onrwmbqXix8U3jEP+izUXdmHfnFap7/8S0HWHODkKuu82
        dULtnElEe7mr5EtAzNHlqFUTYfQzIOAOVFEwoaaBENC1aEmrJWhUc89RPrDM7A3vPTCO7UwYFyes3
        O8el6dQKdQE5dbnpzpt5tUnV4YrivOsS/PbplkZauBePUsIXwCFefT1usZ12wJ5xMgFXANEYQaLkV
        5V+/ZwOYzRr2alyewAjbgY7g/XgdrsmRgu92erTKwspkSyJzbovjoZG+jQOgRTyibedbRb/YqP251
        8/qLFrWw==;
Received: from [98.124.54.9] (port=40750 helo=dummy.faircode.eu)
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1mrhaO-0007sj-Ui; Tue, 30 Nov 2021 01:24:52 +1100
Date:   Mon, 29 Nov 2021 14:24:50 +0000 (UTC)
From:   James <bjlockie@lockie.ca>
To:     Pkshih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
In-Reply-To: <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
References: <5bdf4393-273f-2ad2-40e0-556ec7dc6817@lockie.ca> <867f4b97151745d5a5fa0daa5ebcdbd2@realtek.com>
Subject: RE: USB for rtw89 driver?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <3fef8020-a496-41e3-8974-4d16ff4551b6@lockie.ca>
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


>> Does anyone know if the proprietary driver works on the Raspberry Pi4B
>> (Arm)?
>
> Don't have a proprietary driver neither.

Dlink seems to have added USB support.
I assumed that is proprietary but I guess that is only x86.

https://support.dlink.com/ProductInfo.aspx?m=3DDWA-181-US

There is also an open source USB driver on github=C2=A0 but I don't think i=
t is getting fixes like the lfinger github one.
https://github.com/neojou/rtw89-usb
