Return-Path: <linux-wireless+bounces-12379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A619699B9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC87D287C2F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E55917C9B3;
	Tue,  3 Sep 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="irQ6MYPw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB20719F409
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725358075; cv=none; b=snGOnCx19kGnqfQSEymUCXq7BHSExCo0Ju5iuxwalwOXPGLWVUGEzybop7z7jKnEniD9y/XhQHLKSz9SjqzGyjFTKBwCjToB3v05dS/TTcRTmF8p61VmLdY2s9R56WEjWopLFojVOSXQZ0Q5OjkYs1cI/4eTpqKPNQriy9vkRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725358075; c=relaxed/simple;
	bh=/mIxV0yaj4AJS/251JR33tvnQbbnW/Q57frWK3lyk4I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CX99CINn6Nb5C9LrT3v9AhCrR/rtDCdTJSfKO1LMNEUpR/x0OQAEm8PGaxp+9397wM82JanVMkldv02APcBSwM0nG0kgL0mOrGEVNK52BACWXipvZkPR4Xn/ZzmlJPo+Ry5/oNaiqchF9wzL9taabSGinednN198Y+FSWvD8ANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=irQ6MYPw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/mIxV0yaj4AJS/251JR33tvnQbbnW/Q57frWK3lyk4I=;
	t=1725358073; x=1726567673; b=irQ6MYPwmSLXC5ferkLd1mbCiTAr8ydmNd0PPcLbkTTGcCd
	wONSMi3RveVM/dpIi+laWt/hz2u/BG9r7TxPJMh7CeZWhkPDI6OkVTxjc3QdJMRXVRFjMRXN7n/hU
	O3iLiV4hNhXg6ro7UDYyG7UVSj/7iTY2j2VLHMd+5meUEKPX2X20K3sV3KHAHn1WD3SzVDFwrAEVn
	44d6PGIllBe/IsPrt3VbmlgRc069oW14xOP0ZgvT1w1zvgXKWB7Vp+2yVsAC0g+uEf9ZPdULnVqfa
	z5Kf7dZp2I1TNWqtFjXg1oH9Ecs4kVvJ1G8yf/VsL2CjMRZvSd/kLw7O2ZuwwnmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slQRv-00000002Ciy-1wCq;
	Tue, 03 Sep 2024 12:07:47 +0200
Message-ID: <5bd14f29b58a127ee04d2591a1a59f67b9e44d4d.camel@sipsolutions.net>
Subject: Re: wcn7850 issues
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, Kalle Valo
 <kvalo@kernel.org>
Cc: david Atkins <david@3adesign.co.uk>, Baochen Qiang
 <quic_bqiang@quicinc.com>,  "ath12k@lists.infradead.org"
 <ath12k@lists.infradead.org>, linux-wireless@vger.kernel.org
Date: Tue, 03 Sep 2024 12:07:46 +0200
In-Reply-To: <CAFED-j=i+jZwtFVzoiqXrVAubmDdxhqqVpAPSCRPMPoa6G_chQ@mail.gmail.com>
References: 
	<LO0P123MB4057D6C2F6FEFF335B30EE7CD6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <LO0P123MB4057122D4C7D07C7114F5ABED6BF2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <be53813c-3edc-4734-b59d-83f43f14ea91@quicinc.com>
	 <LO0P123MB4057C3085F445434F5E87B3AD6872@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <26bb8ec7-7170-4a09-ada3-c7c753c16e87@quicinc.com>
	 <LO0P123MB40573F46A6D63145363C6B13D6812@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <cfe8e314-a28b-4ea3-85b2-9f5b4ac2db09@quicinc.com>
	 <LO0P123MB405769E063E48B0F7AE18C5FD68C2@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <LO0P123MB4057E823BDB7B9ECCCD75840D6972@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <a6c609fc-150b-4779-b3f6-dddbd6ce93dc@quicinc.com>
	 <LO0P123MB40578A6CEC43AEFE301F9ED8D6912@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <86bc1623-8845-43fa-9aad-a8a6066b1448@quicinc.com>
	 <LO0P123MB4057266AFF389FA69FDC84B8D6922@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <fb455a66-b29b-4eb0-984c-254f9a1c5626@quicinc.com>
	 <LO0P123MB40578B26075CD4C9C66D144BD6932@LO0P123MB4057.GBRP123.PROD.OUTLOOK.COM>
	 <871q21kwk8.fsf@kernel.org>
	 <CAFED-j=i+jZwtFVzoiqXrVAubmDdxhqqVpAPSCRPMPoa6G_chQ@mail.gmail.com>
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

>=20
> Yes, this is AP issue - hostapd fix required - advertise 0x11111 ...
>=20

You probably don't even want 0x11111111, that would require all MCSes,
which some stations might not support.

Since some things are mandatory, I'm not sure I see a lot of value in
advertising anything non-zero, certainly not by default, and only set it
if specifically want to require something in the BSS that's _not_
already otherwise mandatory.

I mean, maybe you do want to require 4 NSS and all MCSes like the
0x44444444 does, so that regular clients cannot connect ;)

johannes

