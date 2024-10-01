Return-Path: <linux-wireless+bounces-13386-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D98698C5FA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 21:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFCDB20A77
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365AF1B5820;
	Tue,  1 Oct 2024 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ku4azywu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DC1CDA23
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810558; cv=none; b=czQz37FE6Y4S/6hrmwdRsa8SLHajbI1JrsZ+VAPn8uuCLZcTjSRKVeWp6aom42iecpnh32qTnnKLmKqER/YjdH1IG00cLb1UCQvhKy7dq3o9rmyuKcwX7Zo2iWvpK2c6GQl6dBGdrtTJn7g+Ozu5ufjbo5F0bfyC4RW+8jXfzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810558; c=relaxed/simple;
	bh=BDdOvDNbS1EaSltdBsuiWBcIUhZcUmDIdKMmhDb/tbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKpP0NA4SlGft6dhshKuKeq+/LH3DuF5QTLLl7PKk1lRGHbl6xCvPZ5FSdW4HWgjP249YS9gOwl7574WDAHQvO8XAV29waKF4Yfc3xe09QZ7+B1Owx1NT+vvFniYuetmG4WkRBwETL99U7Xsli1lSzzokUfdJg/pEqxfhm5HgC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ku4azywu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727810556; x=1759346556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BDdOvDNbS1EaSltdBsuiWBcIUhZcUmDIdKMmhDb/tbU=;
  b=Ku4azywudrknKzyShWthmK5a83DsZKgfS6yg7LFSGvuQlvT1W1QPQw6E
   3Z1POJWOFvSVwJO8BINE72+QZWMOB4S7jPJavpUG9FrkAOHl6lQ02MVFR
   YVs8Dl8swzYmA896Z54SuATlfpqb5PdP7umXWeQm65s600E2oslV4y9IG
   plo/4k6jJLSXHReu+u5sevZjYOAc/YYjmEUhYio/hVWSReaYZEp7NMF7P
   4rzLgKMjvh2ZD3qaSwx6mcAMjCdfri2ceC5Sh6Ghm4UuKfMFBHYVgcNV9
   CoMDeO0WGz8SDUzOiHrJNcf3TuvPRg9TBrTaJYJ9jsb2zEudSQgLhPhPA
   w==;
X-CSE-ConnectionGUID: jRA6OtgtSlue1p+vHSf+oQ==
X-CSE-MsgGUID: jLFy6SyPSbmlLnegd7hOcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="30850566"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="30850566"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 12:22:35 -0700
X-CSE-ConnectionGUID: /ufsFthCRh2YMhuN+MoIzg==
X-CSE-MsgGUID: c54yxuJvRPiodE5rNaLsOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73891731"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 01 Oct 2024 12:22:33 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 01 Oct 2024 22:22:32 +0300
Date: Tue, 1 Oct 2024 22:22:32 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] iwlegacy: Clear stale interrupts before enabling
 interrupts
Message-ID: <ZvxL-NgAilLPHCSa@intel.com>
References: <20240930122924.21865-1-ville.syrjala@linux.intel.com>
 <20241001181816.GA12474@wp.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001181816.GA12474@wp.pl>
X-Patchwork-Hint: comment

On Tue, Oct 01, 2024 at 08:18:16PM +0200, Stanislaw Gruszka wrote:
> Hi
> 
> On Mon, Sep 30, 2024 at 03:29:24PM +0300, Ville Syrjala wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > 
> > iwl4965 fails upon resume from hibernation on my laptop. The reason
> > seems to be a stale interrupt which isn't being cleared out before
> > interrupts are enabled. We end up with a race beween the resume
> > trying to bring things back up, and the restart work (queued form
> > the interrupt handler) trying to bring things down. Eventually
> > the whole thing blows up.
> > 
> > Fix the problem by clearing out any stale interrupts before
> > interrupts get enabled.
> > 
> > Here's a debug log of the indicent:
> > [   12.042589] ieee80211 phy0: il_isr ISR inta 0x00000080, enabled 0xaa00008b, fh 0x00000000
> > [   12.042625] ieee80211 phy0: il4965_irq_tasklet inta 0x00000080, enabled 0x00000000, fh 0x00000000
> > [   12.042651] iwl4965 0000:10:00.0: RF_KILL bit toggled to enable radio.
> > [   12.042653] iwl4965 0000:10:00.0: On demand firmware reload
> <snip>
> > [   12.052207] ieee80211 phy0: il4965_mac_start enter
> > [   12.052212] ieee80211 phy0: il_prep_station Add STA to driver ID 31: ff:ff:ff:ff:ff:ff
> > [   12.052244] ieee80211 phy0: il4965_set_hw_ready hardware  ready
> > [   12.052324] ieee80211 phy0: il_apm_init Init card's basic functions
> > [   12.052348] ieee80211 phy0: il_apm_init L1 Enabled; Disabling L0S
> > [   12.055727] ieee80211 phy0: il4965_load_bsm Begin load bsm
> > [   12.056140] ieee80211 phy0: il4965_verify_bsm Begin verify bsm
> > [   12.058642] ieee80211 phy0: il4965_verify_bsm BSM bootstrap uCode image OK
> > [   12.058721] ieee80211 phy0: il4965_load_bsm BSM write complete, poll 1 iterations
> > [   12.058734] ieee80211 phy0: __il4965_up iwl4965 is coming up
> > [   12.058737] ieee80211 phy0: il4965_mac_start Start UP work done.
> > [   12.058757] ieee80211 phy0: __il4965_down iwl4965 is going down
> > [   12.058761] ieee80211 phy0: il_scan_cancel_timeout Scan cancel timeout
> > [   12.058762] ieee80211 phy0: il_do_scan_abort Not performing scan to abort
> > [   12.058765] ieee80211 phy0: il_clear_ucode_stations Clearing ucode stations in driver
> > [   12.058767] ieee80211 phy0: il_clear_ucode_stations No active stations found to be cleared
> > [   12.058819] ieee80211 phy0: _il_apm_stop Stop card, put in low power state
> > [   12.058827] ieee80211 phy0: _il_apm_stop_master stop master
> > [   12.058864] ieee80211 phy0: il4965_clear_free_frames 0 frames on pre-allocated heap on clear.
> > [   12.058869] ieee80211 phy0: Hardware restart was requested
> > [   16.132299] iwl4965 0000:10:00.0: START_ALIVE timeout after 4000ms.
> > [   16.132303] ------------[ cut here ]------------
> > [   16.132304] Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
> <snip>
> >  drivers/net/wireless/intel/iwlegacy/common.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
> > index 2147781b5fff..758984d527bf 100644
> > --- a/drivers/net/wireless/intel/iwlegacy/common.h
> > +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> > @@ -2342,6 +2342,8 @@ static inline void
> >  il_enable_interrupts(struct il_priv *il)
> >  {
> >  	set_bit(S_INT_ENABLED, &il->status);
> > +	_il_wr(il, CSR_INT, 0xffffffff);
> > +	_il_wr(il, CSR_FH_INT_STATUS, 0xffffffff);
> >  	_il_wr(il, CSR_INT_MASK, il->inta_mask);
> >  }
> 
> RF_KILL is CSR_INT and we already acknowledged CSR_INT before
> il_enable_interrupts() in il4965_mac_start() -> __il4965_up()):
> 
> 	/* make sure rfkill handshake bits are cleared */
> 	_il_wr(il, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
> 	_il_wr(il, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_DRV_GP1_BIT_CMD_BLOCKED);
> 
> 	/* clear (again), then enable host interrupts */
> 	_il_wr(il, CSR_INT, 0xFFFFFFFF);
> 	il_enable_interrupts(il);
> 
> 	/* really make sure rfkill handshake bits are cleared */
> 	_il_wr(il, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
> 	_il_wr(il, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
> 
> So the only explanation I can see the patch help with the problem
> is additional delay between first and second rfkill handshake bits
> clearing (which BTW looks fishy, since is done 2 times, 
> and seems in the second line in the second clearing bit 
> CSR_UCODE_DRV_GP1_BIT_CMD_BLOCKED should be used).
> 
> I suspect the real problem is that we do enable rfkill
> interrupt by il_enable_rfkill_int() on il4965_mac_stop().
> Since we want to know RF KILL state regardless interface
> is up or down. But then the interrupt is enabled during
> suspend period as well.
> 
> Probably better fix would be add il_disable_interrupts()
> to il_pci_suspend(). Would you like to check that?

That doesn't work, which doesn't surprise me since the state
of the device in .suspend() has no bearing on the state of the
device in .resume() when we're talking about hibernation.

Hmm. I suppose we might want to minimize the potential
changes to any runtime behaviour in which case we could
do this instead:

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 9d33a66a49b5..7f58e31d23fe 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4962,6 +4962,8 @@ il_pci_resume(struct device *device)
 	 */
 	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
 
+	_il_wr(il, CSR_INT, 0xffffffff);
+	_il_wr(il, CSR_FH_INT_STATUS, 0xffffffff);
 	il_enable_interrupts(il);
 
 	if (!(_il_rd(il, CSR_GP_CNTRL) & CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW))

which does work.

> 
> If not, patch is ok for me, if it fixes the issue in practice.
> 
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

-- 
Ville Syrjälä
Intel

