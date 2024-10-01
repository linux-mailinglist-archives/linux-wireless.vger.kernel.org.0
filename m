Return-Path: <linux-wireless+bounces-13383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EC98C547
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 20:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37314285397
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3FD1CCB54;
	Tue,  1 Oct 2024 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="WuHB42Ly"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C3F1C9B65
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807102; cv=none; b=EjXN1ATnfPRaGJXounaPJPR59NDlKQ07jEcgzY8Fl6Qsusdna8Bq9Tda8J7NKvAohqMwBGEzQqnN2dnRtO8xjn8BmqAwGVN/+PehHVllUgy8kz5nijlQNNnBL5ycztFzFHRnMIoWHqXHlGiAwPn7qpAkKvm/yx+TyOtqNks0Qmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807102; c=relaxed/simple;
	bh=el0fdQq1SZIBgxoZFiw6Lh4n9dzwZTOWn/Ti3kTgdVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmAiY9lUWy9ss738VnuVj27nEtuOMt3cJ1ddqDrflFz4pTn1aOhr7d/0v5iI8PlnfXQ4te6pUq691r03t8By8CiafdCOhgUrphFyLBnP7XaCORGHJb1+GWyEGdTlpvoLU1DMMN59Ycr+2S9x9o259HOdQjKetIuPjbw/HYsXcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=WuHB42Ly; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 27897 invoked from network); 1 Oct 2024 20:18:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727806697; bh=C6xlVDre8wiV4FkVy+HduMGXgKEBAyJap9Dk6Py+RB8=;
          h=From:To:Cc:Subject;
          b=WuHB42LyrDw6LYxGVY+6zD1vGVDTnJovux9rt+5VBgXfvEw4GtNx5HY+ADOvH9aiO
           KFWhhqDHjHI2VuWiNluC22zKVkvzYF9QHDWHvgN9kuZ0O8tlUhBxlXXAfGbUXaBIMu
           beZ3QvMz2YyOROGInqhKU8Ubqwo3KKm7dGGVd8Ko=
Received: from 89-64-14-248.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.14.248])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <ville.syrjala@linux.intel.com>; 1 Oct 2024 20:18:17 +0200
Date: Tue, 1 Oct 2024 20:18:16 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH] iwlegacy: Clear stale interrupts before enabling
 interrupts
Message-ID: <20241001181816.GA12474@wp.pl>
References: <20240930122924.21865-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930122924.21865-1-ville.syrjala@linux.intel.com>
X-WP-MailID: 564abd02ed6b8075956687a43469dfc8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [EcOk]                               

Hi

On Mon, Sep 30, 2024 at 03:29:24PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> iwl4965 fails upon resume from hibernation on my laptop. The reason
> seems to be a stale interrupt which isn't being cleared out before
> interrupts are enabled. We end up with a race beween the resume
> trying to bring things back up, and the restart work (queued form
> the interrupt handler) trying to bring things down. Eventually
> the whole thing blows up.
> 
> Fix the problem by clearing out any stale interrupts before
> interrupts get enabled.
> 
> Here's a debug log of the indicent:
> [   12.042589] ieee80211 phy0: il_isr ISR inta 0x00000080, enabled 0xaa00008b, fh 0x00000000
> [   12.042625] ieee80211 phy0: il4965_irq_tasklet inta 0x00000080, enabled 0x00000000, fh 0x00000000
> [   12.042651] iwl4965 0000:10:00.0: RF_KILL bit toggled to enable radio.
> [   12.042653] iwl4965 0000:10:00.0: On demand firmware reload
<snip>
> [   12.052207] ieee80211 phy0: il4965_mac_start enter
> [   12.052212] ieee80211 phy0: il_prep_station Add STA to driver ID 31: ff:ff:ff:ff:ff:ff
> [   12.052244] ieee80211 phy0: il4965_set_hw_ready hardware  ready
> [   12.052324] ieee80211 phy0: il_apm_init Init card's basic functions
> [   12.052348] ieee80211 phy0: il_apm_init L1 Enabled; Disabling L0S
> [   12.055727] ieee80211 phy0: il4965_load_bsm Begin load bsm
> [   12.056140] ieee80211 phy0: il4965_verify_bsm Begin verify bsm
> [   12.058642] ieee80211 phy0: il4965_verify_bsm BSM bootstrap uCode image OK
> [   12.058721] ieee80211 phy0: il4965_load_bsm BSM write complete, poll 1 iterations
> [   12.058734] ieee80211 phy0: __il4965_up iwl4965 is coming up
> [   12.058737] ieee80211 phy0: il4965_mac_start Start UP work done.
> [   12.058757] ieee80211 phy0: __il4965_down iwl4965 is going down
> [   12.058761] ieee80211 phy0: il_scan_cancel_timeout Scan cancel timeout
> [   12.058762] ieee80211 phy0: il_do_scan_abort Not performing scan to abort
> [   12.058765] ieee80211 phy0: il_clear_ucode_stations Clearing ucode stations in driver
> [   12.058767] ieee80211 phy0: il_clear_ucode_stations No active stations found to be cleared
> [   12.058819] ieee80211 phy0: _il_apm_stop Stop card, put in low power state
> [   12.058827] ieee80211 phy0: _il_apm_stop_master stop master
> [   12.058864] ieee80211 phy0: il4965_clear_free_frames 0 frames on pre-allocated heap on clear.
> [   12.058869] ieee80211 phy0: Hardware restart was requested
> [   16.132299] iwl4965 0000:10:00.0: START_ALIVE timeout after 4000ms.
> [   16.132303] ------------[ cut here ]------------
> [   16.132304] Hardware became unavailable upon resume. This could be a software issue prior to suspend or a hardware issue.
<snip>
>  drivers/net/wireless/intel/iwlegacy/common.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
> index 2147781b5fff..758984d527bf 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.h
> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> @@ -2342,6 +2342,8 @@ static inline void
>  il_enable_interrupts(struct il_priv *il)
>  {
>  	set_bit(S_INT_ENABLED, &il->status);
> +	_il_wr(il, CSR_INT, 0xffffffff);
> +	_il_wr(il, CSR_FH_INT_STATUS, 0xffffffff);
>  	_il_wr(il, CSR_INT_MASK, il->inta_mask);
>  }

RF_KILL is CSR_INT and we already acknowledged CSR_INT before
il_enable_interrupts() in il4965_mac_start() -> __il4965_up()):

	/* make sure rfkill handshake bits are cleared */
	_il_wr(il, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
	_il_wr(il, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_DRV_GP1_BIT_CMD_BLOCKED);

	/* clear (again), then enable host interrupts */
	_il_wr(il, CSR_INT, 0xFFFFFFFF);
	il_enable_interrupts(il);

	/* really make sure rfkill handshake bits are cleared */
	_il_wr(il, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);
	_il_wr(il, CSR_UCODE_DRV_GP1_CLR, CSR_UCODE_SW_BIT_RFKILL);

So the only explanation I can see the patch help with the problem
is additional delay between first and second rfkill handshake bits
clearing (which BTW looks fishy, since is done 2 times, 
and seems in the second line in the second clearing bit 
CSR_UCODE_DRV_GP1_BIT_CMD_BLOCKED should be used).

I suspect the real problem is that we do enable rfkill
interrupt by il_enable_rfkill_int() on il4965_mac_stop().
Since we want to know RF KILL state regardless interface
is up or down. But then the interrupt is enabled during
suspend period as well.

Probably better fix would be add il_disable_interrupts()
to il_pci_suspend(). Would you like to check that?

If not, patch is ok for me, if it fixes the issue in practice.

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

