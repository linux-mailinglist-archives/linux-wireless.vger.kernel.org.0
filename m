Return-Path: <linux-wireless+bounces-6054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4189E506
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 23:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88E51F2294E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 21:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D133158A1A;
	Tue,  9 Apr 2024 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qV7AVBUH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1A158A0E;
	Tue,  9 Apr 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698614; cv=none; b=Kw1RZ8uFe4vlqCGVVASKe7krAidBu5pEyHfYAjZWDAU5xp7LnrneTBVpaiLnVSuo9dgduh3v25Mf3JJj0nvC/Gxt0vfvEO7uSiF+9RfujIuu8Qhow8do3IT397BjDfsleVF0QRJsw7IUbuJcorKc9hMoxm/0yCpP9g7CpuotePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698614; c=relaxed/simple;
	bh=DnLOeLETMfr9szDDiTAWX9eoEbMZT8svSFqOh4k7jb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZEfeSemvmxKnoVmtVVhnu9/XRpRvfUbEUhorJNuyt4bUqYLJV6upGNaBKXLJZCPgYvBpyL6wMuxULlVMX62oyyXpcAc1YHkOF2q2dxBZPeYCzeg31pdbOogy6lxDKd+P7jGyyEfrPWrd5aGOgj9PuMZtrbRkZth7d5CEWlJPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qV7AVBUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FE7C433C7;
	Tue,  9 Apr 2024 21:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712698613;
	bh=DnLOeLETMfr9szDDiTAWX9eoEbMZT8svSFqOh4k7jb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qV7AVBUHnH0DfbZGWscQ85F51SrwD666zZzJpmq24viHXRQ28ze1azompCotzHETq
	 3skThZ+CrSTuKlGAg8KjDgMhwS5d97WPMTXLzaUoxZzbL+PilEscDpG9dFjDFtQUJ/
	 0I0csVV7eyjvr2jqI9egjh9TmRgMMOUyOKyiv8NNBZi/eRWm/TZRfNkkCwp1ccMFqM
	 frgrF9NSGFVCXbhn5vK7L3rqNbEXnOAwDEBWawZV5iTFPZ557s/lAcdh4XdbS58mrc
	 fNEqBe9iJwtX3tVsrjzRlNGkACJOxA3ObuoBrbHk0BdIKvUlFH38ly+AZP2PeqmzeY
	 TimcWEvz5NKIA==
Date: Tue, 9 Apr 2024 14:36:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>,
 <manivannan.sadhasivam@linaro.org>, <linux-wireless@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] net: qrtr: support suspend/hibernation
Message-ID: <20240409143652.57bc8cc3@kernel.org>
In-Reply-To: <87il0q28a5.fsf@kernel.org>
References: <20240305021320.3367-1-quic_bqiang@quicinc.com>
	<20240305021320.3367-3-quic_bqiang@quicinc.com>
	<8734s02b3s.fsf@kernel.org>
	<87il0q28a5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 12:29:54 +0300 Kalle Valo wrote:
> No reply from netdev maintainers but as the patch is marked as 'Not
> Applicable' in netdev patchwork I guess they would not have major
> objection to take this to ath.git. It should go to net-next in the next
> wireless-next pull request anyway.

Sorry for the silence, FWIW no objection/opinion here.

