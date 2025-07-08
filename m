Return-Path: <linux-wireless+bounces-24901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6557AFC1B1
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 06:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407784A70E5
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 04:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A2E55B;
	Tue,  8 Jul 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.in header.i=@nic.in header.b="i4bA/Soo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vastu71.nic.in (vastu71.nic.in [164.100.2.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707EA7464
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 04:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=164.100.2.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751948916; cv=none; b=oPsZgt0frhgJIOj5+/k3z61KicYazJVcYikcxYT/r0ME9aaLQASuZnyYRyRyZJRqvtrf596ZNhdDvoYN/dz3zOi9oPok3tkieF1Qv3YkTfHho9peJNwY5YCxNSXiD31y93CXgyq+YpDaV0O1slGE2ftF3TVecIMBDVr3iAVqrvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751948916; c=relaxed/simple;
	bh=8zVyEFYwNm9gNs3KtoxVg4Qx4JtFh744mvI2eIJkQS4=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=T5iZrruo7fTh29DbCoDEnrX8ywGbPjOWxnwLUhPfUR6RNYo0ao4bD2aHdQtnlWiwE3qlE1dMwWdC3H/eBhPzXAs/cZj9zhL54P53C0tqzBtp+RSUBvnDq40IbVJl8NYTRh/jRXSF1Kwk/3W4K6bCLyabKeECgzOfmc3eGOSGoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.in; spf=pass smtp.mailfrom=nic.in; dkim=pass (1024-bit key) header.d=nic.in header.i=@nic.in header.b=i4bA/Soo; arc=none smtp.client-ip=164.100.2.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nic.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nic.in
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=nic.in; i=@nic.in; q=dns/txt; s=NIC; t=1751948911;
  x=1783484911;
  h=date:from:to:cc:message-id:subject:mime-version:
   content-transfer-encoding;
  bh=8zVyEFYwNm9gNs3KtoxVg4Qx4JtFh744mvI2eIJkQS4=;
  b=i4bA/SoolQAtlUEGvuL5qI8Npl2n9RH+bgAmxSvkr1z7IBF2TFnEVGMt
   MK2fRBzKd1h6GP03EfhCwqz2A5XkL6bq91rB+lmSOmFhefin9DpFeI0qc
   dwvotAqxd/oCctgFfJ1sKJWKm2jruYKAbMseOv/ehMxokAZ+yhRm0hMwr
   c=;
Date: Tue, 8 Jul 2025 09:49:06 +0530 (IST)
From: Gaurav Kansal <gaurav.kansal@nic.in>
To: pkshih@gmail.com
Cc: wens@kernel.org, linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Message-ID: <1456091345.1517853.1751948346004@nic.in>
Subject: Re: [PATCH 2/3] wireless-regdb: update regulatory rules for India
 (IN) on 6 GHz for 2025
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Thread-Index: fUcE6nIo7yjuqNMY0G+Oz4IZtHkpcA==
Thread-Topic: wireless-regdb: update regulatory rules for India (IN) on 6 GHz for 2025


Hi All,

One query with respect to adding EIRP values (or max power) in the database.
As per draft regulations, max EIRP across different channel bandwidth will differ in 6 GHz band.

Like, in 20 MHz channel bandwidth, max allowed EIRP will be 18 dBm whereas for 320 MHz channel, the max allowed EIRP will be 30 dBm.

How we can add this info in the wireless regdb ? Apologies if i am missing something.

Regards,
Gaurav Kansal



On Jul 8, 2025, at 06:21, pkshih@gmail.com wrote: 

Chen-Yu Tsai <wens@kernel.org> wrote: 

BQ_BEGIN

I see. 

I will drop this for now then, unless Ping-Ke has any more information 
on this? 




What I can find is a consultation [1] on May this year. It needs some 
time to have decision then. 

Please drop this. 

[1] https://www.trai.gov.in/sites/default/files/2025-05/CP_28052025.pdf 

BQ_END



