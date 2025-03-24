Return-Path: <linux-wireless+bounces-20745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC8A6D711
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 10:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E03A9FCC
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4828D25D917;
	Mon, 24 Mar 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FIdz+bY9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1A25DAE3;
	Mon, 24 Mar 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742807505; cv=none; b=bOdjXPm6J4zRGSe9WN89xZzX9wm6f/ezPTgjRaGLJHc/CqqvwGPdlmSDAjeafv+NqWJp9bRFtK20VnQ1QI+w+OiwfSLcEhT3ppG7DazzXYzfRAlRg6G/cGv9mlBPl4ra1nSALPkOAslXxdk65Pv3+0+V9bcr2H2AwvTEGqjunDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742807505; c=relaxed/simple;
	bh=xtSXh6+Zee/Qft/ZxFihJqkWvvhc0WQOhGMs9uEvn2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lDPkY0htH7Are60DnyDXNVD97j/L49JiRJZADQlWaRz3vNGwOzymmWSq5B7rGQk6l7ZKJxeu+/aBGwp1poORsXOz68DGDnbPmJLt2WFFicnjNCGShFyGjMyTLQy20pEsQYWpH5qvxvM8hNA2AbrmWkPBBGKAX5KP/j+x1dEr6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FIdz+bY9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ClmexxLxtozHEJVd1kpHjy+FBvc2bx8jEjpjkQaesy0=;
	t=1742807503; x=1744017103; b=FIdz+bY9YVYWs87kGsN8m6+Dzbl2uoaQzuqS4CHBlq0I+Ee
	PnX0OlKV8szjS6h50YiI6Eln0xodcIzfw2bEUQBWbY4nVgnAfjivnmM42R5ilhB+mk3rkaSHZ2m3s
	EmEhBzw+Srxa+fg46+DQANB6Sp6qqTKYULBzXOAzSEr0+1nCfyq1yGEsQmfKvieKvzMcvLq7VjslD
	rX9Cc0XcMUYeJubsXaA4NwraXJE3zAMjvCuBPQr08wSfoSL3bc905wVrlFM4vruph6jD8flPqVeql
	p9AdCnUn4JV+AuFHcvQ3sbTuSxuwduby088LgKn2+mbWA4rYxJk96kOp+Ejw9Dmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1twdqH-00000003u77-0qg7;
	Mon, 24 Mar 2025 10:11:33 +0100
Message-ID: <c1848940ceaf2f716041eefcaba381202f5e50c4.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: iwlwifi:: fix spelling errors
From: Johannes Berg <johannes@sipsolutions.net>
To: Wang Liang <wangliang74@huawei.com>, miriam.rachel.korenblit@intel.com, 
	ganjie182@gmail.com, emmanuel.grumbach@intel.com, avraham.stern@intel.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Mar 2025 10:11:31 +0100
In-Reply-To: <20250324030021.2296493-1-wangliang74@huawei.com>
References: <20250324030021.2296493-1-wangliang74@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-03-24 at 11:00 +0800, Wang Liang wrote:
> Fix some spelling errors in comments:
>  - configuraiton -> configuration
>  - notificaiton -> notification
>=20
> No functional changes.
>=20

FWIW, spelling errors really don't need to be fixed on wireless, that
can wait for wireless-next.

johannes

