Return-Path: <linux-wireless+bounces-15099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E80149C08E0
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94621C24159
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F045A29CF4;
	Thu,  7 Nov 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GE84TVP9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1A212196
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989726; cv=none; b=tmbFzl94ayHeeWsDNMZM1jvlPDf/AerI9QtITrp4MKlDHNFMwGk0+NTh0pgcK0PnCicuq3/VBlN2DIr1XxSfXYfjYvHMNwOuvEJc5JReZw8fOecl2xj/MREG8H/sEjTwM1a0/3HUmwtSG0CtH29JO8n2FXEEPmG5yJOnpaOIelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989726; c=relaxed/simple;
	bh=PzYfFNnz7KUHjxIVO9eXJV32YNK7Tadtpgha9RHKwH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Prv9ZKKjLUItew5C0j+HxUAs7h+oUwRWm/EPl+w6h7CeXzMt0XGvOR0Q1NqcThl9S0daSaUroEBzXV9iMbwVKlUw9pA212RAAPi1erdCSyd/MCNQmHZ3n8TiQE8kESS6LoBSLjZlW8Gfc84C2eFhKWYK8A0abFu5/Mtw9/sLnY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GE84TVP9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PzYfFNnz7KUHjxIVO9eXJV32YNK7Tadtpgha9RHKwH0=;
	t=1730989725; x=1732199325; b=GE84TVP9sITdsFAtV1IJUkS8ti4r98+NWwrCouVYSvhNO2C
	oGyemBneYBI2dR9TCn3UInz+7W5FshxumAUEV3E/NaEiCH79c+reFZ631RS38UocDAKIuSSGzQaWN
	qpUtdLRbsHeIka20MUWt7bdGOoaWaOm66F0O0eTRPjg8O3EawyxvsEndRO0WfZ+aZWAfChR3wcDAh
	zP5IdyP5DhfkSBXHM3XOF5lkJjXox74uN6N/jaxXkbkFUlcUGhKrCELifwg3uuLvDHKaGkV6pg/9t
	AP8WyDXXcuSqQn2yzcF3FidveaBLTi0mbvgD++NrewI7LtrPErAX01h9QBybdf0A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t93V5-0000000GS8k-1flp;
	Thu, 07 Nov 2024 15:28:43 +0100
Message-ID: <24c0236141df8d0ffb9a48037cbca000086c53b7.camel@sipsolutions.net>
Subject: Re: [PATCH 0/5] mac80211: change disassociation order
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 07 Nov 2024 15:28:42 +0100
In-Reply-To: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
References: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

This patchset doesn't apply (some patches not cleanly, some not at all),
but I'm not sure why. Perhaps it requires merging wireless back first?

Please resend when it applies on wireless-next.=20

johannes

