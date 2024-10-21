Return-Path: <linux-wireless+bounces-14246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53769A5F08
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F87A1C246E3
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CBF196C67;
	Mon, 21 Oct 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKoSVn4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D091799F
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500410; cv=none; b=FXqizdn+sHpDzHGEEeURefHrpHpWsPIM3OLBC52ovgrI23Kngj9IxSvVBCD+JRciEachuSoVmI0TWhQWjTMJ+qBZYXhpwcq6vJnRg1ZZfO62rRekc9oKtYZI96FcqFLKO/WtLbBcsC8JQr2M3vEA1LRkY5ZdnrrMz0S/XWUqRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500410; c=relaxed/simple;
	bh=JtPklSIFPtZfF1yiS+TaXT18UoyuB3gyohnvuVOh6sw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JQuxS4+UN8pgOyJ86wIJZpXdtu1/VvT7ZvH8lhD6oGNfrMlMVwHK0reFs5Wto5gTDNgo9X342ZxRWVfGS0A4kvxYP+zDLMAjM0p4wve5fKo97n1TjWB242aM6c1DVOwvmFbHq0ZwAEjTW7UQsLJdISxznmrotfsxyNqojCJKo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKoSVn4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F8BC4CEC3;
	Mon, 21 Oct 2024 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729500410;
	bh=JtPklSIFPtZfF1yiS+TaXT18UoyuB3gyohnvuVOh6sw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XKoSVn4gSoT+BAGpeUdysiMQhHIG4TBpwtJbSkFWIgEFqDsU378DGwYIcvdhqUdlM
	 DnfNhpY4mrFSH4X9MUaV5IQPsxNZJntz5mHPjEXN/bslZ5idsLXmfi+UFy1gmDrMCT
	 21M/hgQhFcdwaPay0aX7hSIVgyEkS9IphtKJNrT0vEwI5L1SftnMiDHYJugEkW2Vx4
	 I6sDFDHle3CjVBtIQWFmGJv7O4L7kQoyiIXygK5Y1J21WVBYH8AaQJUk1B5G/baaKs
	 UuZNFy4Izo/ctwvT7slgq2QfMgEiw8PHSDqBhlFwNxjV/Tghkjw3UrB6T7jM8DrJ3O
	 zPPq/yhQ4/kMA==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] wifi: ath12k: delete NSS and TX power setting
 for monitor vdev
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
	<20241016065700.1090-9-quic_kangyang@quicinc.com>
Date: Mon, 21 Oct 2024 11:46:47 +0300
In-Reply-To: <20241016065700.1090-9-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Wed, 16 Oct 2024 14:56:57 +0800")
Message-ID: <871q09rgg8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> ath12k_mac_monitor_vdev_create() will set NSS and TX power for monitor
> vdev. But this is not needed for monitor vdev.
>
> So delete them.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

Does this fix any known issues? Or is just cleanup?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

