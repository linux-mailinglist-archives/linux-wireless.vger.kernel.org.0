Return-Path: <linux-wireless+bounces-13714-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68B994108
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2391C2152E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975E713A41F;
	Tue,  8 Oct 2024 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aTuzmyHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6414E2F5
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728373024; cv=none; b=t2CbiKKFJm+QyvdHlkDqR9olE13CJTlaaBsQ2U+rQOLm6XLe0g/upGfCUiiwcq05CBwU2G/E4U6hazE9yoeCTU6BkP9H3fLLDTfJ+UMsGKJcSOuJdmgp0fDCgPjbQEiof51fV0Nax0mq1Tngn9uZvQ1yi2sysjEyK36sBfZMqsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728373024; c=relaxed/simple;
	bh=XvGKBMhZDMW4oeX0knao9Wj8IrRJFInNfUY359OFN7o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjlXXctBjtwQ9UUH1zx2o+fe75nGHqB/LQ5UDPeGw148En/sLqIEMYaG4Q+0K0qlBivY4Pw4rV1soaGuX8STEAbZ/8pYu1smxCqxEhTB+XQmft+Dr6qz9CDwa+OUP9cRz95kVNDPPTnxDm4iLVK0PzJFEkKaxAKT1gccphQnhcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aTuzmyHm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XvGKBMhZDMW4oeX0knao9Wj8IrRJFInNfUY359OFN7o=;
	t=1728373023; x=1729582623; b=aTuzmyHmnsw9v3JU9fLfRVl5YYzjfxrjrv1qJvdUJvCgdLu
	9xwdS0EgTo5hiJD7W+iMfwsjYtOnHZLNXCpr85xnHZ67gSaIGd9+wroYOdiw/OwKHMhAvcrJX04Z6
	PeIiVLb+jzCxCne+TWNlB6ZphHUi107AJE45dAq6hTQXuPXvJm/qzvW2cvmmhlGeloF6GqzPQiWDf
	E95LAgFrNn3sZAswbJrN0dEWSndTiax5+tzEZ5EOY6zCxX+U9zI5gWms4f5/2HzF+Q4+D0cn94Szd
	YM7I5GwcoMfD1Yr1xPSGlhf9mcREXJBFXaMamhmUEI0kqeAFKDsC3gu9OMCB3N1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sy4mB-000000048Tr-0dAa;
	Tue, 08 Oct 2024 09:36:59 +0200
Message-ID: <a66621974d1bdaf4ef9c922907786cf757cb4fac.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: re-order assigning channel in
 activate links
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 08 Oct 2024 09:36:58 +0200
In-Reply-To: <97054998-0793-4c71-a202-dd5167fcc24d@quicinc.com>
References: <20241001085034.2745669-1-quic_adisi@quicinc.com>
	 <93df47a867ee1f8d84cabdbc953707eab2ea3704.camel@sipsolutions.net>
	 <6504caf7-e9d5-49ff-983e-73335f8ee3a1@quicinc.com>
	 <97054998-0793-4c71-a202-dd5167fcc24d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-10-08 at 10:43 +0530, Aditya Kumar Singh wrote:
>=20
>=20
> Is your testing complete? Do you see any issues with this change?

Yeah, it can be made to work, but we're still discussing the best way
with some internals (slowly, due to the holidays in Israel).

I think you can just leave this patch as is, and I'll keep it pending in
patchwork until we figure it out, and then I'll just amend it with the
iwlwifi changes when I merge it.

johannes

