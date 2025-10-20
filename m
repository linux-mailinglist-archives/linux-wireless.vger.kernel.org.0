Return-Path: <linux-wireless+bounces-28104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D530BF1BD5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 16:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A5AC34D2C5
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 14:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F771BCA1C;
	Mon, 20 Oct 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="paenrdLB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F1320CDF
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969322; cv=none; b=nhn1GVORYmQ8bR3FRCipwKEcfS9OHvYqxPB4SbOLTVlAXwf2A6mBC/fL/mR6mbcF+pF5EtUwWr/vOvreNTAHDoC0XwkRx+1g8irY5kryRafHnsjOJ4AyQF7qdlXgTjtCliZHRtDEy6XxC6P+qEmSnisbqQyjdyOPCQCs1lWcr5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969322; c=relaxed/simple;
	bh=m4M7oCGY+Pfnh34Yg8R744ZtZDgIhMaGkefgYHzduQ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SnX+MMHHOAVIPLyxnvJtbEuAIoZsRSrzwuiuqwK4fJ5kGwj+w4T/V1pRSQ8QNJFnTJSnQQC5rW5N8Krp03y4w2r6IvX7gEKZk2DZv4mfHJY3unkvmkD2m6M1CIaL9jlXCS4VcTDFo+hndQ8rBrAwon8LYDa4NGt4Qm3LZtLUOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=paenrdLB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m4M7oCGY+Pfnh34Yg8R744ZtZDgIhMaGkefgYHzduQ0=;
	t=1760969320; x=1762178920; b=paenrdLB2zxNTSSTQNJc5UoSy/aIp9f80r7vfNZsErGPUhb
	EMu0npAuWNiFcT5+9JlWzPD88c7MLYCOR08Gdm7azp0QH9pu7ZSLlqfK1VtunHjUinfWgPuX0w90D
	/3YAYJeBkesFoiImWEg4eACtTkTjiRmDlwlrP7TThJYoeLrcjbWHkxbEzBlLJDDC41Hh5O3tSoECY
	KJ/GsR1PsdRi/NN5NXNjAO88IwGbf3Gto8kq+TEZr1je+WjMblW0J7t7H7kRZ4jhbBEh+sPxsh1al
	tG80TEp9YECKQ+unVerK21PfFvcOZkEHGmjSeNpHN2HMQVlazw4Vb3MDtf7lynXQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vAqYv-000000092nw-3mD7;
	Mon, 20 Oct 2025 16:08:38 +0200
Message-ID: <6b0634994bc8428f8ebcf4032ff98604660c52fa.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2] wifi: mac80211: Try to overcome bad HE
 operation in association response
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>
Date: Mon, 20 Oct 2025 16:08:37 +0200
In-Reply-To: <20251019115152.e1cf791232a6.I69591428f2b9bde9df3c78c333e9b4fc264da0d9@changeid>
References: 
	<20251019115152.e1cf791232a6.I69591428f2b9bde9df3c78c333e9b4fc264da0d9@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-10-19 at 11:52 +0300, Miri Korenblit wrote:
> From: Ilan Peer <ilan.peer@intel.com>
>=20
> Some APs, e.g., some versions of Aruba APs,

My understanding is that both Ruckus and Aruba have fixed these issues
now (not sure how that'll roll out though), so I think we should
probably not make this change at this point, unless we know that will be
a significant number of APs that cannot get updated?

johannes

