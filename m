Return-Path: <linux-wireless+bounces-18088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFCAA211C8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 19:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AB73A384A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 18:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47621DC98A;
	Tue, 28 Jan 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="n36aieNM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715921DE4FA;
	Tue, 28 Jan 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089938; cv=none; b=inC/U13516FZTLcvV89vP4qzoRXSVI+5OK3raqK4+me3jQGR/tcHfzxUuRgQEjurnbj3m58naOyTf2XF6JnjB/D1v06V2IMTXnwJ07+7GFAu335OnK+vbk8wNWe8CD/z5lCRsjJxAeAJZVzw6nFy9EACZxTk2kx9XirPyYJJMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089938; c=relaxed/simple;
	bh=P5aceI4+NYNHORCSXryT6KP22DVJfooeeHn3piZhh84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu0PhWo8KgrGKwOdGR0gRXOmYv0z1dPdCOcRqzxJjSdHdRbByOid552YEit+BHE8sjRx3zFvhf7maPFejAGvT7srUXJ0eGjHYB23WUZHGNcyOd8BRnt8Qb8mJknSQTlMIZFrvOpAyuukdpmpZ+zCiEU7v9rq5KjM04wkEcMw2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=n36aieNM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=hXpTpRs0Hbgyf9UFVerskCDc2G/jngTnN+jofZI40TQ=; b=n36aieNMMOvAKRG2
	vkxuHIpy+8gLdUt4/uRP2AITr+82cgpJyoBZEApgSjAoQoxq1eXLOBUGk7xhsTc9AroikYNL+8Aj0
	ejgqb2PXMehMnFzM/eTWifSOec2h6j5cNVGWUlHlTBsb70W5KUE0psmFIbBj6cEZdFQjWs75MaoiM
	eGRvn5F7pOq8TThs/I87VstEX6JEOsogZjz1KhLrkCq4XQeQ5yGFfWWz4RfijY+B4oJOhUZxvjAm2
	SSPxu+Fst/jkgoH13A7F9B6HqsQRi28TxzfKXrwd8kegXpIj5yk3Ys0BM5P+H54akp+fgC7OlOQPS
	9zTi6AGdlOJTlekAwA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tcqaZ-00CWqm-0Y;
	Tue, 28 Jan 2025 18:45:31 +0000
Date: Tue, 28 Jan 2025 18:45:31 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: miriam.rachel.korenblit@intel.com, kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iwlwifi: Cleaning up deadcode
Message-ID: <Z5kly5whELp8h1k3@gallifrey>
References: <20241223013202.340180-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241223013202.340180-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 18:45:02 up 265 days,  5:59,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Hi,
>   This is a collection of removal of functions
> that have been used for more than a few years.
> 
>   There are also a handful of string and one structure
> removal that are just left overs from a recent commit.
> 
> They're all entire function/structure/string removal.
> 
> Build tested only.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

A gentle ping on this just-pre-christmas set please.
Thanks!

Dave

> 
> 
> Dr. David Alan Gilbert (6):
>   iwlwifi: Remove unused iwl_rx_ant_restriction
>   iwlwifi: Remove unused iwl_mvm_rx_missed_vap_notif
>   iwlwifi: Remove unused iwl_mvm_ftm_*_add_pasn_sta functions
>   iwlwifi: Remove unused iwl_mvm_ftm_add_pasn_sta
>   iwlwifi: Remove unused iwl_bz_name
>   iwlwifi: Remove old device data
> 
>  .../net/wireless/intel/iwlwifi/cfg/22000.c    |   1 -
>  .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   8 --
>  drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   1 -
>  drivers/net/wireless/intel/iwlwifi/dvm/tt.c   |  11 --
>  drivers/net/wireless/intel/iwlwifi/dvm/tt.h   |   1 -
>  .../net/wireless/intel/iwlwifi/iwl-config.h   |   4 -
>  .../intel/iwlwifi/mvm/ftm-initiator.c         | 101 ------------------
>  .../intel/iwlwifi/mvm/ftm-responder.c         |  86 ---------------
>  .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  23 ----
>  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  12 ---
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  61 -----------
>  drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 -
>  12 files changed, 313 deletions(-)
> 
> -- 
> 2.47.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

