Return-Path: <linux-wireless+bounces-18214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF75A229D9
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 09:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22AE188791D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7531953A1;
	Thu, 30 Jan 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="sN6n+dL3";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Qrp25eiB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i103.smtp2go.com (e3i103.smtp2go.com [158.120.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174E518FDC5
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738227187; cv=none; b=eHeYqXncgHKCP/u6mIwdB8EeUi/q/Rn/wECIg2U+Hdm2EipB2M8hiJouQ32axTi8VYoDil3qJnnQum3CLN5lews+6xAJKxntiQ3FTT3Q59ErvxwtYqbdwcBFQI2Oy7JgdjJnhaR95QibcsOvlngpvWO3D8nvZL44PduRHR/6WKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738227187; c=relaxed/simple;
	bh=XzxeJ4XPzzp0usFqTbZ0M1nRoFpn4ZTZJon5i7ounms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3OvaWKFm3dzFG4bus3T4wSrjJGFTxG1J6atU2PfYF5OzZ/La46DT3SijIxswpPpucRqAgaRUDFrgiOir4XJxw4vkX5NbilaqedVkIANYsrycQMg7uxYslwJhTT1/8pA22XFg2EDtlaUTIMkn03ZekidfcU4oRNVgrV6U16+RxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=sN6n+dL3; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Qrp25eiB; arc=none smtp.client-ip=158.120.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1738227180; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=ztTkXggYlobgx0epsppi5S+4LOlRnswYqg61lPztKMQ=;
 b=sN6n+dL3aKsm0GTAjx37lMc6zYq91YImND6qbOANCH37P0iX6nCcnRhzMKhCpwwrYSsM0
 gaCqQDOaOk0o7MVEg37OLcyrAvArNveYboGW4YmSxiOjimrK0EylZywAarpTnhbqwFQmAiW
 If4o/JsWx6N+NmRNCmh6dkAZ1Xlpujr8Ru4Gv22okbzS9p+cJokAHSevURqODM1fUw/1htR
 Zwif0POwvqS6B/egCYcQgG905wc+ImVfopYb3E/v/gCrWL98Z50j8hrKKps/s0MOA2Pns6e
 Tg9SAtldKx3AJKgdAZ9RCn3NNFu1M8cgL4fFN8/V5qVrapKhWfSNtQN6UgAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1738227180; h=from : subject
 : to : message-id : date;
 bh=ztTkXggYlobgx0epsppi5S+4LOlRnswYqg61lPztKMQ=;
 b=Qrp25eiB5UFQLe+3xFMEstY2lj5rT8sKpRXGgpkjMJksj/TEqV1Rp/0C52XP9AyzgY3B6
 7WdvoQOCfXqGrWFKykuBrVcV/Q8mrtQG1XIhplA/HxhVQ0sdfQpCyQDjjlOUtKA+32qd7nQ
 SH6dyoUxgqF1D2nyL4+XSJZS/hr/N69JZT4vStuSyJAoxGE6sldsvAI7sS4MjNFofmB5OKY
 aJs4jWmAZzJpFvH9ZrQyVyz1y97B6uRx8SolUpZaI8SMU6diyju2oDxi4U7pocxcqdsxxw1
 H98PGQO6DTkl/E2EiA4I6TfSyh3FXgPfSuubv57epMWYdyHTTmQYmHzAzDyg==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1tdQIF-4o5NDgrn3Ce-oqLA;
	Thu, 30 Jan 2025 08:52:59 +0000
Date: Thu, 30 Jan 2025 09:49:12 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>
Subject: Re: [PATCH v2] wifi: ath12k: remove return for empty tx bitrate in
 mac_op_sta_statistics
Message-ID: <Z5s9CO_mmazq2Kg1@pilgrim>
References: <38c2a7c4f7eaf57b9306bb95a9e6c42b7d987e05.1738169458.git.repk@triplefau.lt>
 <9c12e9b9-35a4-47f1-bd17-6b4641de92a4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c12e9b9-35a4-47f1-bd17-6b4641de92a4@oss.qualcomm.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sX7BLYLfdb
X-smtpcorp-track: NtTCJqLkdc3l.FVQEFL1tgX-Y.7cVO1w80khh

On Thu, Jan 30, 2025 at 12:21:54PM +0530, Aditya Kumar Singh wrote:
> On 1/29/25 22:25, Remi Pommarel wrote:
> > Currently in ath12k_mac_op_sta_statistics() there is the following
> > logic:
> > 
> >      if (!arsta->txrate.legacy && !arsta->txrate.nss)
> >          return;
> > 
> > Because ath12k_sta_statistics is used to report many info to iw wlan0 link,
> > if it return for empty legacy and nss of arsta->txrate, then the other
> > stats after it will not be set.
> > 
> > To address this issue remove the return and instead invert the logic to set
> > the txrate logic if (arsta->txrate.legacy || arsta->txrate.nss).
> > 
> > The same was done also in both ath10k with commit 1cd6ba8ae33e ("ath10k:
> > remove return for NL80211_STA_INFO_TX_BITRATE") and ath11k as well with
> > commit 1d795645e1ee ("ath11k: remove return for empty tx bitrate in
> > mac_op_sta_statistics").
> > 
> > Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> MISSING_BLANK_LINE
> 'Tested-on:' tag missing blank line after it.
> 
> You missed v1 comment? :)

Yes sorry I think your mail never reached me, did you CC me ? Do you
need a respin ?

-- 
Remi

