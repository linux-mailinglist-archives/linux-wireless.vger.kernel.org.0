Return-Path: <linux-wireless+bounces-20622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A06A6B240
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 01:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C56E1885002
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 00:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010A3D69;
	Fri, 21 Mar 2025 00:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OBq83rvt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9E5684
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 00:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516954; cv=none; b=TEdNEqm+Hr5LrHpWOFQaKQxiOCZepjSBBuzGMKCSY2p6tqQrRh+BOt9Z21wch3GmeTsgf7H19u6kn5S6f84VHzWgEMqMyGNn67APlHW2OIWTGWMZjzuyCNa5nLLWMRXf3tmmUGTCyQdFmGPLYU2GIdN6Ozr3zQhrtPphsCGqPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516954; c=relaxed/simple;
	bh=KWpuuYNjbFifpBB92arwXqW4AaC+uELuLSDAR4Bcq4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EOS/a+fiHV21QA1Stc10ZV5HwOHN5y7+1FsIjuRamPzsRRvuujDXc5W8pjC1+gvcdmiSIlmlTjw1CyvLvsl3ZkRkr6k5bOI/2MbBEBQnqpo3wbPqiVnK+ZGSpQh0org9H3oH+cQbvBckxgj3oKvrLLbGC/gedrurzFFjp5+cGIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OBq83rvt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52L0SWcX43452500, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742516913; bh=KWpuuYNjbFifpBB92arwXqW4AaC+uELuLSDAR4Bcq4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=OBq83rvtsJXq1QnHROUhvXekTcRLraCTbqx+CIv/WaIWgmy8mIi8WFU6k4FsxEfuI
	 FrkSPzOZajiD+qsaGSgk/zOyAOisUmfM459dcdXv1VBdf3FsGTAEjzJ7XEybEJYXRP
	 CWLNvHErs+KUIZMDSgiUTNN5GXVDO/OMLlAmnkIwA2uuAhs3FRVn2IUfPNwldCL00M
	 XFNTLJd7cQqYQT885b0sYiCshO3YDD3Ay/sJWux8O+6lAcGgT9FU/u1aR3C45F3vlL
	 /GbF0kljqWzy/UlFSbU6IHruQMMEzEkWKH7E+1WvIGU71I5SkC/0wVaY3AJjWPi1V8
	 thj+QXBpdDKhA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52L0SWcX43452500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 08:28:32 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Mar 2025 08:28:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 21 Mar 2025 08:28:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 21 Mar 2025 08:28:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Pradeep
 Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: RE: [PATCH ath-next v3] wifi: ath12k: Fix incorrect rates sent to firmware
Thread-Topic: [PATCH ath-next v3] wifi: ath12k: Fix incorrect rates sent to
 firmware
Thread-Index: AQHbmYq//PwbxUp6H06yZFoV/EHxRLN8vPsg
Date: Fri, 21 Mar 2025 00:28:32 +0000
Message-ID: <8399ca6fa2f34898a86d07d822a09a5d@realtek.com>
References: <20250320112426.1956961-1-quic_rdevanat@quicinc.com>
In-Reply-To: <20250320112426.1956961-1-quic_rdevanat@quicinc.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Roopni Devanathan <quic_rdevanat@quicinc.com> wrote:
> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>=20
> Before firmware assert, if there is a station interface in the device
> which is not associated with an AP, the basic rates are set to zero.
> Following this, during firmware recovery, when basic rates are zero,
> ath12k driver is sending invalid rate codes, which are negative values,
> to firmware. This results in firmware assert.
>=20
> Fix this by checking if rate codes are valid, before sending them
> to the firmware.
>=20
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>=20
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

For the __ffs() part,=20

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>


