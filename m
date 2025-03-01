Return-Path: <linux-wireless+bounces-19638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453B8A4AB47
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 14:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022003B6206
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Mar 2025 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649621DF25E;
	Sat,  1 Mar 2025 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="h1bQVUEG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F621DE4D2
	for <linux-wireless@vger.kernel.org>; Sat,  1 Mar 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740836221; cv=none; b=cPhl6aOlw3dwz/RefItQ9RIECywid+OlS1F4/ShbIbe4sGZNdHazOIH10XC14n0dKX/I+gknCjhjDvLtoecP8VAqaITrqvU0MDJjxIi2OSupM/Nyj31K1WdoPdWyiaN83sBsYqxAA+akJwuhO7tuRu3PykDVpdwtvM5fCew/xvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740836221; c=relaxed/simple;
	bh=LapoCgKb7rpfKJfF20IZl7hsT2Euatqkb1ZMHZXrBLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lktfohK7M3KY9nrqU+gvjrZ3wkJR/w8mJvHmt/Rx5zPROyMHjKUdqx8NHqHmV/vcIrAJCMZu8NEtUJIqpYwQWYymVl+izQ3wfncT2McrYNsDCvD8y7pSoOOrWTE6lHbLFmsXMguyrEvK4U5Xu/Vv9e7D56m9RjELBRjM7ORRjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=h1bQVUEG; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 15989 invoked from network); 1 Mar 2025 14:36:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1740836213; bh=aRiFh+RnguF32GhIHTChLBANgiv5uAT2Dw8NdRyvRj4=;
          h=From:To:Cc:Subject;
          b=h1bQVUEGMNTUKae/W7vCi/u1TvVyU1xwrMft7ayL9P4r3CIEB2ZoSF/NYpjZjWNro
           X4eNtKTyrDqgx7KP4TnECypWCVjsdNOPUjtM460l1ulP6n6i8q1C0iT9TJazBjaFe3
           yAYV4wDaRqtsCM879tQFQAPJPUFTGdQvAwd0mRSjHiGGEuJYchsYTvwQC0v74y1y8P
           OR8tDQKLBUSGLKu86RV7jQn0Qvq8RAYzsyOENlTbMI3cu4+0OXMOmd2CsLYj55fr3b
           7pHEn8OlnTi4BDdlkha2iMXTPHvRc94Y1RX2TxkyNGLp8hTmDXOPDwQIscSQMDMHq+
           6aPvj9zdFgq1Q==
Received: from 89-64-0-97.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.0.97])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <arnd@arndb.de>; 1 Mar 2025 14:36:53 +0100
Date: Sat, 1 Mar 2025 14:36:52 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kalle Valo <kvalo@kernel.org>, Ben Hutchings <ben@decadent.org.uk>,
	linux <linux@treblig.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iwlegacy: don't warn for unused variables with
 DEBUG_FS=n
Message-ID: <20250301133652.GA60453@wp.pl>
References: <20250225145359.1126786-1-arnd@kernel.org>
 <20250301122834.GA55739@wp.pl>
 <994e4827-0e16-4e05-be7c-1ca7a86e4daf@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994e4827-0e16-4e05-be7c-1ca7a86e4daf@app.fastmail.com>
X-WP-MailID: 2470ba4e58919c2f21eb6df4d58800ac
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [McMU]                               

On Sat, Mar 01, 2025 at 01:38:16PM +0100, Arnd Bergmann wrote:
> On Sat, Mar 1, 2025, at 13:28, Stanislaw Gruszka wrote:
> > On Tue, Feb 25, 2025 at 03:53:53PM +0100, Arnd Bergmann wrote:
> >
> > But then the code will be compiled for !CONFIG_MAC80211_DEBUGFS
> > case, it does compile for me:
> >
> > -  22475	   1160	      0	  23635	   
> > 5c53	drivers/net/wireless/intel/iwlegacy/4965-rs.o
> > +  23008	   1168	      0	  24176	   
> > 5e70	drivers/net/wireless/intel/iwlegacy/4965-rs.o
> 
> Very strange, this really shouldn't happen. Which symbols
> exactly do you see the compiler fail to drop with my patch,

nm 4965-rs.o diffrence before and after patch:

                  U ieee80211_rate_control_register
                  U ieee80211_rate_control_unregister
                  U ieee80211_start_tx_ba_session
                  U ieee80211_stop_tx_ba_session
 0000000000000010 t il4965_hwrate_to_plcp_idx
-00000000000043b0 T il4965_rate_control_register
-00000000000043e0 T il4965_rate_control_unregister
+00000000000043f0 T il4965_rate_control_register
+0000000000004420 T il4965_rate_control_unregister
 00000000000002e0 t il4965_rate_n_flags_from_tbl
 0000000000000000 t il4965_rate_n_flags_from_tbl.cold
 0000000000000270 t il4965_rs_alloc
 0000000000000710 t il4965_rs_alloc_sta
 00000000000000dd t il4965_rs_alloc_sta.cold
-0000000000001810 t il4965_rs_collect_tx_data.isra.0
-00000000000012b0 t il4965_rs_fill_link_cmd
-0000000000000495 t il4965_rs_fill_link_cmd.cold
+0000000000001850 t il4965_rs_collect_tx_data.isra.0
+0000000000000e90 t il4965_rs_dbgfs_set_mcs.isra.0
+00000000000002f6 t il4965_rs_dbgfs_set_mcs.isra.0.cold
+0000000000001340 t il4965_rs_fill_link_cmd
+0000000000000518 t il4965_rs_fill_link_cmd.cold
 00000000000002a0 t il4965_rs_free
 0000000000000e40 t il4965_rs_free_sta
 000000000000028d t il4965_rs_free_sta.cold
@@ -173,31 +184,31 @@
 0000000000000a20 t il4965_rs_get_best_rate
 0000000000000bb0 t il4965_rs_get_rate
 0000000000000209 t il4965_rs_get_rate.cold
-0000000000001180 t il4965_rs_get_tbl_info_from_mcs.isra.0
-0000000000003bd0 T il4965_rs_rate_init
-0000000000000d5f t il4965_rs_rate_init.cold
+0000000000001210 t il4965_rs_get_tbl_info_from_mcs.isra.0
+0000000000003c10 T il4965_rs_rate_init
+0000000000000de4 t il4965_rs_rate_init.cold
 00000000000002c0 t il4965_rs_rate_init_stub
 0000000000000760 t il4965_rs_set_expected_tpt_table
 0000000000000490 t il4965_rs_stay_in_table
 0000000000000088 t il4965_rs_stay_in_table.cold
-0000000000001000 t il4965_rs_switch_to_mimo2.isra.0
-00000000000003c3 t il4965_rs_switch_to_mimo2.isra.0.cold
-0000000000000e90 t il4965_rs_switch_to_siso.isra.0
-00000000000002f6 t il4965_rs_switch_to_siso.isra.0.cold
+0000000000001090 t il4965_rs_switch_to_mimo2.isra.0
+0000000000000446 t il4965_rs_switch_to_mimo2.isra.0.cold
+0000000000000f20 t il4965_rs_switch_to_siso.isra.0
+0000000000000379 t il4965_rs_switch_to_siso.isra.0.cold
 00000000000000d0 t il4965_rs_tl_rm_old_stats
 00000000000001a0 t il4965_rs_toggle_antenna
-0000000000001970 t il4965_rs_tx_status
-00000000000004d4 t il4965_rs_tx_status.cold
+00000000000019b0 t il4965_rs_tx_status
+0000000000000559 t il4965_rs_tx_status.cold
                  U il_debug_level
                  U il_is_ht40_tx_allowed
-0000000000001180 R il_rates
+00000000000012a0 R il_rates
                  U il_send_lq_cmd
                  U jiffies
                  U jiffies_to_msecs
 000000000000004b r .LC15
 0000000000000070 r .LC9
-0000000000001100 r rs_4965_ops
-0000000000001210 r rs_ht_to_legacy
+0000000000001220 r rs_4965_ops
+0000000000001330 r rs_ht_to_legacy
                  U __stack_chk_fail
                  U __ubsan_handle_out_of_bounds
                  U __ubsan_handle_shift_out_of_bounds

> and which compiler version are you using?

It is:
gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2)

I've checked on other system with
gcc (GCC) 14.2.1 20240912 (Red Hat 14.2.1-3)
and there size difference is similar:

-  28876	   4875	      0	  33751	   83d7	drivers/net/wireless/intel/iwlegacy/4965-rs.o
+  29454	   4851	      0	  34305	   8601	drivers/net/wireless/intel/iwlegacy/4965-rs.o

> > How about moving  
> > static const struct il_rate_mcs_info il_rate_mcs[RATE_COUNT]
> > under CONFIG_MAC80211_DEBUGFS ? Maybe inside the function that use it ? 
> 
> It's not supposed to make a difference, let's try to figure
> out if there is a compiler bug or a mistake in my patch first
> and then fix it in the right place.

Regards
Stanislaw

