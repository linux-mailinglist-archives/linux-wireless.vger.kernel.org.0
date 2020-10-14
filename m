Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67A928E527
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Oct 2020 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgJNRN4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Oct 2020 13:13:56 -0400
Received: from pop32.abv.bg ([194.153.145.222]:43302 "EHLO pop32.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbgJNRN4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Oct 2020 13:13:56 -0400
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop32.abv.bg (Postfix) with ESMTP id 48829200BA
        for <linux-wireless@vger.kernel.org>; Wed, 14 Oct 2020 20:13:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1602695634; bh=9/Krwybd0+I0cEbXc3A2BgECCViA5KRYRwtkjkVRLFc=;
        h=Date:In-Reply-To:References:Subject:To:From:From;
        b=pAmVuufiWzEbcxCHLOkIBUHEp8CQIewhBnbQrWkM2QES96ZlIVuiZgd9CkTWK7WR4
         fh5s4JMvcQOk6oZYvyFixiBFe05hiK45VgVUE/+cXIIx/7L2cc8XuF4AOn5wOlS03o
         98FbTDujoBd+DFM7OozIXEGWm+q1pO+YKvH91Ihs=
X-HELO: [192.168.1.131]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=buboleck@abv.bg
Received: from 46-249-79-198.net1.bg (HELO [192.168.1.131]) (46.249.79.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted); Wed, 14 Oct 2020 20:13:54 +0300
Date:   Wed, 14 Oct 2020 20:13:50 +0300
User-Agent: K-9 Mail for Android
In-Reply-To: <C2B7DFBB-4F07-4790-98DE-44BCFA72C530@abv.bg>
References: <C2B7DFBB-4F07-4790-98DE-44BCFA72C530@abv.bg>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: RTW88 does not support rtl8821ce RFE 4
To:     linux-wireless@vger.kernel.org
From:   Dimitar Kosev <buboleck@abv.bg>
Message-ID: <1A3B6524-C775-4ACB-BF99-CCD9F2700B06@abv.bg>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

My laptop Asus M509DA is using RTL8821CE RFE4, it is not supported:

[ 2=2E324824] rtw_8821ce 0000:01:00=2E0: enabling device (0000 -> 0003)
[ 2=2E329142] rtw_8821ce 0000:01:00=2E0: Firmware version 24=2E5=2E0, H2C =
version 12
[ 2=2E350506] rtw_8821ce 0000:01:00=2E0: rfe 4 isn't supported
[ 2=2E350612] rtw_8821ce 0000:01:00=2E0: failed to setup chip efuse info
[ 2=2E350615] rtw_8821ce 0000:01:00=2E0: failed to setup chip information


Kind regards=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
