Return-Path: <linux-wireless+bounces-9512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C4A915740
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 21:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634A11F210C4
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 19:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B441A01BC;
	Mon, 24 Jun 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="E+ngmmiR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9C1E4A9;
	Mon, 24 Jun 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257839; cv=none; b=Onv1fSpuMYg3Pb7zpuYiJFG2O9GZibQNt1kloMTOyOwF/rK1gplDA+2JNRO4/ENj3BeEvvzpU4S7bv9Ow5RxEakpbuoE/e/X8U8AV2F5sKC4uv2ur+Wc4ehZKu/V5TzzlsLmpjPrKWdP0pSPGNXYCLI6JBej/I7hcw1s/lMhPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257839; c=relaxed/simple;
	bh=11S+M97XQpaeJqwbIqa8g/OjnDsw3HbK6rLVP/bKW88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7fJVU17N5/qQ/Zr8+P0cQa3A4X/v54SSnbcih0u1On67ZAO0YD88SmpzsvkJbv86mK7Opj4HGzxWhWSB3NAGEBrTQnd6i2Vx/q2M5hVigA2pB5HcJl9yxGZxoNjuhjWPlQEiyc8+y2nUnBLxHe8JAeXK8JCc67zpIOqV/+O6vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=E+ngmmiR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=11S+M97XQpaeJqwbIqa8g/OjnDsw3HbK6rLVP/bKW88=;
	t=1719257836; x=1720467436; b=E+ngmmiRTllagnnj6oHLmp/7wevcWW6IoX2l6frWMU2HQ6F
	wEXeT3hQivT6FRNJbhOGecazFl1C9nct7PKmlVfmA0al7Mnz0d/SBNwlP4NxEL7s1V4IHm4d7Ty+T
	YgCpngFe5JT76DcMdmlLptrF756c++s3BO2UOYWUJ1OeGt/ET72akTOEFXTzIFxkOYCsVB6PTSNQg
	JXfpp7NAtN3s/8Rv/qtaD2jj4PcG9PIRQGyO6xVzb0ihTp90Wgws6Y3x0y6DsY2j+aCrYsv65R3/N
	gkbMG7qr5EKj+38oRsyHWXDaJQYgxyDabfFJAM6RlCyIOiNBxYN9LtWIogo1Oi6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sLpUv-0000000GtdC-0TwW;
	Mon, 24 Jun 2024 21:37:05 +0200
Message-ID: <1b8a249383003e035baf849af5da36ca4732ebea.camel@sipsolutions.net>
Subject: Re: [RESEND PATCH v4] iwlwifi: mvm: adding check if the thermal
 firmware is running
From: Johannes Berg <johannes@sipsolutions.net>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>, 
 miriam.rachel.korenblit@intel.com, kvalo@kernel.org,
 rafael.j.wysocki@intel.com,  daniel.lezcano@linaro.org,
 gregory.greenman@intel.com, dmantipov@yandex.ru
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 21:37:03 +0200
In-Reply-To: <20240624191428.39681-1-trintaeoitogc@gmail.com>
References: <20240624191428.39681-1-trintaeoitogc@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Please stop resending this every two days!

johannes


