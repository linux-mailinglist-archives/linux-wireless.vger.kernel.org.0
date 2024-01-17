Return-Path: <linux-wireless+bounces-2095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791C2830742
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FCD28A444
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BEE1EB57;
	Wed, 17 Jan 2024 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVDFa0qV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A41DFDE
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498992; cv=none; b=JSuUMtDgChjxJTFC7mjpHDJhOGhahEepN4hsVnGZQ4J4pX1SAHPbcNDki4TBr5+dpyKLHTYsZVC3+gRTin7UQ/IZsoDv0ENoKx7Mx+r1DqzS3V7Z/bEgzq62aDShEq6z+Fk6HSpsDgsXfZN3pUVDGJ0YZqgAtV75xKrq1FOneWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498992; c=relaxed/simple;
	bh=rNryY6hYZlO1btpN6zBV4mq9B44lFRLTK0qMjrq9rBg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=SgYGoxrijB4332HsdjISyUGs64sMa1oFAfWNFzdH51MMhoixAd6m4Z7/0IgwEmD5ITgbJ7q4yk5756uNB2wf/uhIYciE29ALW0nV0DeGo+Fygu3fUgVZLhNipkhvq7UnW3sClR0SjSbffCPa68y7CkebZB7ggigTVMBW2uJVYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVDFa0qV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107C3C433F1;
	Wed, 17 Jan 2024 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705498991;
	bh=rNryY6hYZlO1btpN6zBV4mq9B44lFRLTK0qMjrq9rBg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=PVDFa0qVeQgfcmtTLvCT/aURzwV29B744wxAwuaQ73mWhuWPqchRniFVuU5H5Hl+D
	 wvaaY+VBJHOffrmv/+3ae0fqYxsk1hjP+jAcoWZh5+f7Djg8ZFWQw6Wus7P6wHfAmR
	 gZLPkTtEMSRsWZp5XbLgDJyzbAn0VgO+15CCtdY9wr/QO6/o36gNoeckVCGNl5RYL8
	 0njz6HRmRyNVe+OYUDuq/RyHTfhQTqWrSfCrsjNXWtgzSvXEKccH7BaMuAV+vTdrZg
	 F4sRRbPDC5l4cAZN/jX4LN+hDJ7IfB2gB1hdtrhi55QHCCRfAxtKBNNrmlLglnHue5
	 HdAzIj0EiSXTw==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
  linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org
Subject: Re: ath11k and vfio-pci support
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<8734v5zhol.fsf@kernel.org>
	<87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
	<87r0ipcn7j.fsf@kernel.org>
	<356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
	<26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
	<87mstccmk6.fsf@kernel.org>
	<df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
	<8734v4auc4.fsf@kernel.org>
	<e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
	<285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
	<4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
	<3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
	<ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
	<16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
	<cdec259a-b779-4856-8585-f285179e3671@gmail.com>
Date: Wed, 17 Jan 2024 15:43:08 +0200
In-Reply-To: <cdec259a-b779-4856-8585-f285179e3671@gmail.com> (James
	Prestwood's message of "Wed, 17 Jan 2024 05:20:24 -0800")
Message-ID: <87cyu05b4j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Prestwood <prestwoj@gmail.com> writes:

>>> I don't see anything in the dmesg logs, or in lspci etc.
>>>
>> fee00578 is the physical MSI vector so I got it using lspci in host, see
>> ...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enabl=
e+ Count=3D1/32 Maskable+ 64bit-
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Address: fee00578=C2=A0 Data: 0000
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Masking: fffffffe=C2=A0 Pending: 00000000
>> ...
>
> Mine looks like this:
>
> ...
>
> =C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable- Count=3D1/32 Maskable+=
 64bit-
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 Address: 00000000=C2=A0 Data: 0000
> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 Masking: 00000000=C2=A0 Pending: 00=
000000

And that lspci output is from the host (not the guest)?

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

