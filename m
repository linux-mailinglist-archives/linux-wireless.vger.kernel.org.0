Return-Path: <linux-wireless+bounces-14931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29359BD2FE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 17:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F801F2334E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 16:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE81DC185;
	Tue,  5 Nov 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="G3c6UEui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxc.seznam.cz (mxc.seznam.cz [77.75.79.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B411DD86F
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.79.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825845; cv=none; b=H5BHFfQVHjG6uDYMYQyttCFCuo9W/ug7ITE5Y4H4zoPSodQngkzyi4a72nhnaA63PVavnT9tuLNC2qqCIYT+vkIkJEc4+A0Qy1nKdKqt2SiRRtlv2WJ8/bKskIe0SerznOihM/4qA4spyzDKILfi8IVfTCsSlYQpkU8/8rxdKJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825845; c=relaxed/simple;
	bh=wZax6wDVB33j78pkU185h9AtdhUKr+dMnlqwMKn3C8A=;
	h=From:To:Cc:Subject:Date:Message-Id:References:In-Reply-To:
	 Mime-Version:Content-Type; b=BUfBN5j+F3bVLBzEEpbf+dN14vjILgCPtGrosSiOwDLznLdw6qDoXhomWU+jZ9IWzUYFDgy2c6UFU1bTVKufe3WzLiN7DPUdo3SLSTGLzVxQqxKlDt0e/2sBcbuU/g0cdaC+Z03pIgJg/V5FV93CS4EnNwFQ/tklxX1nEXujcJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=G3c6UEui; arc=none smtp.client-ip=77.75.79.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Received: from email.seznam.cz
	by smtpc-mxc-6fb77d897d-8qbns
	(smtpc-mxc-6fb77d897d-8qbns [2a02:598:64:8a00::1000:47b])
	id 78e476788610c4d2786af860;
	Tue, 05 Nov 2024 17:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
	s=szn20221014; t=1730825837;
	bh=wZax6wDVB33j78pkU185h9AtdhUKr+dMnlqwMKn3C8A=;
	h=From:To:Cc:Subject:Date:Message-Id:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=G3c6UEuiN68R2RAeLlyIy/VEw/Eqw98rszxqIre35UKxWCSbaMPvHSZQ+8CS7wuDu
	 CE+pVNSn8IX4tOkd8/qwK+0oB9u2UnTRUJIBdJg4zf4NQPMKzY8eWX/vM05Ow/PURX
	 RxHlOAH0P5IyPNpQx3aVW9g9BAgVntMzEvlZ9TLV2XpiCeZWW8KdZQiRyAap1zrGL4
	 7UCv9OFHbdesuXtPoHdhfiY/x2xQhawdNBB68vl2ZIycojFuNqTP/hmHx0rHSLPWxX
	 S3FtkT760OrEXJxBPZQo2I+zlNAcU/H2WlnW83kUHGhUMctz7jBWYhkSdmymxzrYGS
	 NG13oVq1v/T8w==
Received: from 184-143.ktuo.cz (184-143.ktuo.cz [82.144.143.184])
	by email.seznam.cz (szn-ebox-5.0.191) with HTTP;
	Tue, 05 Nov 2024 17:55:53 +0100 (CET)
From: "Tomas Paukrt" <tomaspaukrt@email.cz>
To: "Felix Kaechele" <felix@kaechele.ca>
Cc: <linux-wireless@vger.kernel.org>,
	<ath10k@lists.infradead.org>,
	"Kalle Valo" <kvalo@kernel.org>,
	"Jeff Johnson" <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v2 2/2] wifi: ath10k: add support for QCA9379 hw1.0 SDIO
Date: Tue, 05 Nov 2024 17:55:53 +0100 (CET)
Message-Id: <7P.ZxiX.7YuMJP8eRMw.1dAauP@seznam.cz>
References: <20240908013244.496382-1-felix@kaechele.ca>
	<20240908013244.496382-3-felix@kaechele.ca>
	<c1385aa1-0d41-4ed7-a00c-e40c69bafeaa@kaechele.ca>
In-Reply-To: <c1385aa1-0d41-4ed7-a00c-e40c69bafeaa@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.61)
X-Mailer: szn-ebox-5.0.191
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

I would like to support the adoption of changes like this one, as they ess=
entially cannot break support for other devices.

I submitted simple and non-conflicting patches that added QCA9377-7 suppor=
t few months ago, but they were also deferred.

Best regards

Tomas

