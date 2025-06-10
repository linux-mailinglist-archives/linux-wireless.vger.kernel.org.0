Return-Path: <linux-wireless+bounces-23942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75323AD4104
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 19:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BAF1898428
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE4244662;
	Tue, 10 Jun 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UY4DIFWU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EC21019C;
	Tue, 10 Jun 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749577312; cv=none; b=HrQhh16ogcgSt/m/739Mh04VCJvqKEdnLc6GaDuJCrWyXvYcvvq+Akjagu++6TL6lqbDwtWJMjhYk/j3qxV1HhYRDFhC1F4ZZjPtmp2JUqkgESLLyQZ/2qCiOZrQXGh95cCIgDFFYDE1Nw9eCqntKv/t15b//tB0A0np5lW9s80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749577312; c=relaxed/simple;
	bh=sRkw8ZsJ4kvpK7qB5Fr0oq2ZSj7pwh8y4ZDPoB3jyFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubx/DOPQQUxdrl0ya76t+i6ptxy/Q7B/yKesul1DPYRUA6u0xSGSt3uEYymwiNC8p5QK6fTuZ84d+gCavq6T1HZtQUzjW9hAsbkJRETROI9jzSQjzGh7Px9gF6bblVFhGEKzw9/dZP5IeOT/yqaZq7gg17F6cRHtKNejz1MbjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UY4DIFWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBD2C4CEED;
	Tue, 10 Jun 2025 17:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749577311;
	bh=sRkw8ZsJ4kvpK7qB5Fr0oq2ZSj7pwh8y4ZDPoB3jyFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UY4DIFWUk+S8Rlf6pVsaugp9+cz3GLQVU9yPCEPzUWsF8vKmL3sttS6Ir1DrALavT
	 NO1/WTOseFT9whVFWayqR++eY/GAai+QX0HMX6foi+ARDlEdk2QQTNWk3/M+Zl+hfy
	 AmjS63rB0IK7QVH8wqJjtWRtAmeanoZgyxl9Nx1RwwOScRRTY66c7MTvL2lfofo4TH
	 31sbXjmpzQnyaX054hfs9hG6pC5DvWYiFsZc2muZMGexBMYLcTa1ZrLZtA7S09Xxcs
	 vVKbxOD4lDdsZ2EBB9AHz1Nlpm31+NUJu1ToHjCifkfy2brxHeczg9BF+RT4d5RfST
	 luFfQy2iHStaQ==
Date: Tue, 10 Jun 2025 12:41:49 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: bjorn.andersson@oss.qualcomm.com, Jeff Johnson <jjohnson@kernel.org>, 
	Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>, Mahendran P <quic_mahep@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath12k: Avoid CPU busy-wait by handling VDEV_STAT
 and BCN_STAT
Message-ID: <v44xnvqxjdqtonpfvnn6iblzmchgxbhtj7t25dhaxcimippba5@rbjf5roopwdx>
References: <20250609-ath12k-fw-stats-done-v1-1-2b3624656697@oss.qualcomm.com>
 <c2d138ba-5b08-4daa-95b3-e1f95f05938d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2d138ba-5b08-4daa-95b3-e1f95f05938d@oss.qualcomm.com>

On Tue, Jun 10, 2025 at 01:16:30PM +0530, Rameshkumar Sundaram wrote:
> 
> 
> On 6/10/2025 8:36 AM, Bjorn Andersson via B4 Relay wrote:
> > From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > 
> > When the ath12k driver is built without CONFIG_ATH12K_DEBUG, the
> > recently refactored stats code can cause any user space application
> > (such at NetworkManager) to consume 100% CPU for 3 seconds, every time
> > stats are read.
> > 
> > Commit 'b8a0d83fe4c7 ("wifi: ath12k: move firmware stats out of
> > debugfs")' moved ath12k_debugfs_fw_stats_request() out of debugfs, by
> > merging the additional logic into ath12k_mac_get_fw_stats().
> > 
> > Among the added responsibility of ath12k_mac_get_fw_stats() was the
> > busy-wait for `fw_stats_done`.
> > 
> > Signalling of `fw_stats_done` happens when one of the
> > WMI_REQUEST_PDEV_STAT, WMI_REQUEST_VDEV_STAT, and WMI_REQUEST_BCN_STAT
> > messages are received, but the handling of the latter two commands remained
> > in the debugfs code. As `fw_stats_done` isn't signalled, the calling
> > processes will spin until the timeout (3 seconds) is reached.
> > 
> > Moving the handling of these two additional responses out of debugfs
> > resolves the issue.
> > 
> > Fixes: b8a0d83fe4c7 ("wifi: ath12k: move firmware stats out of debugfs")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > ---
> >   drivers/net/wireless/ath/ath12k/debugfs.c | 58 --------------------------
> >   drivers/net/wireless/ath/ath12k/debugfs.h |  7 ----
> >   drivers/net/wireless/ath/ath12k/wmi.c     | 67 +++++++++++++++++++++++++++----
> >   3 files changed, 60 insertions(+), 72 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath12k/debugfs.c b/drivers/net/wireless/ath/ath12k/debugfs.c
> > index dd624d73b8b2714e77c9d89b5a52f7b3fcb02951..23da93afaa5c25e806c9859dbbdd796afd23d78a 100644
> > --- a/drivers/net/wireless/ath/ath12k/debugfs.c
> > +++ b/drivers/net/wireless/ath/ath12k/debugfs.c
> > @@ -1251,64 +1251,6 @@ void ath12k_debugfs_soc_destroy(struct ath12k_base *ab)
> >   	 */
> >   }
> > -void
> > -ath12k_debugfs_fw_stats_process(struct ath12k *ar,
> > -				struct ath12k_fw_stats *stats)
> > -{
> > -	struct ath12k_base *ab = ar->ab;
> > -	struct ath12k_pdev *pdev;
> > -	bool is_end;
> > -	static unsigned int num_vdev, num_bcn;
> > -	size_t total_vdevs_started = 0;
> > -	int i;
> > -
> > -	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
> > -		if (list_empty(&stats->vdevs)) {
> > -			ath12k_warn(ab, "empty vdev stats");
> > -			return;
> > -		}
> > -		/* FW sends all the active VDEV stats irrespective of PDEV,
> > -		 * hence limit until the count of all VDEVs started
> > -		 */
> > -		rcu_read_lock();
> > -		for (i = 0; i < ab->num_radios; i++) {
> > -			pdev = rcu_dereference(ab->pdevs_active[i]);
> > -			if (pdev && pdev->ar)
> > -				total_vdevs_started += pdev->ar->num_started_vdevs;
> > -		}
> > -		rcu_read_unlock();
> > -
> > -		is_end = ((++num_vdev) == total_vdevs_started);
> > -
> > -		list_splice_tail_init(&stats->vdevs,
> > -				      &ar->fw_stats.vdevs);
> > -
> > -		if (is_end) {
> > -			ar->fw_stats.fw_stats_done = true;
> > -			num_vdev = 0;
> > -		}
> > -		return;
> > -	}
> > -	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
> > -		if (list_empty(&stats->bcn)) {
> > -			ath12k_warn(ab, "empty beacon stats");
> > -			return;
> > -		}
> > -		/* Mark end until we reached the count of all started VDEVs
> > -		 * within the PDEV
> > -		 */
> > -		is_end = ((++num_bcn) == ar->num_started_vdevs);
> > -
> > -		list_splice_tail_init(&stats->bcn,
> > -				      &ar->fw_stats.bcn);
> > -
> > -		if (is_end) {
> > -			ar->fw_stats.fw_stats_done = true;
> > -			num_bcn = 0;
> > -		}
> > -	}
> > -}
> > -
> >   static int ath12k_open_vdev_stats(struct inode *inode, struct file *file)
> >   {
> >   	struct ath12k *ar = inode->i_private;
> > diff --git a/drivers/net/wireless/ath/ath12k/debugfs.h b/drivers/net/wireless/ath/ath12k/debugfs.h
> > index ebef7dace3448e4bdf2d6cb155d089267315172c..21641a8a03460c6cc1b34929a353e5605bb834ce 100644
> > --- a/drivers/net/wireless/ath/ath12k/debugfs.h
> > +++ b/drivers/net/wireless/ath/ath12k/debugfs.h
> > @@ -12,8 +12,6 @@ void ath12k_debugfs_soc_create(struct ath12k_base *ab);
> >   void ath12k_debugfs_soc_destroy(struct ath12k_base *ab);
> >   void ath12k_debugfs_register(struct ath12k *ar);
> >   void ath12k_debugfs_unregister(struct ath12k *ar);
> > -void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
> > -				     struct ath12k_fw_stats *stats);
> >   void ath12k_debugfs_op_vif_add(struct ieee80211_hw *hw,
> >   			       struct ieee80211_vif *vif);
> >   void ath12k_debugfs_pdev_create(struct ath12k_base *ab);
> > @@ -126,11 +124,6 @@ static inline void ath12k_debugfs_unregister(struct ath12k *ar)
> >   {
> >   }
> > -static inline void ath12k_debugfs_fw_stats_process(struct ath12k *ar,
> > -						   struct ath12k_fw_stats *stats)
> > -{
> > -}
> > -
> >   static inline bool ath12k_debugfs_is_extd_rx_stats_enabled(struct ath12k *ar)
> >   {
> >   	return false;
> > diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> > index 60e2444fe08cefa39ae218d07eb9736d2a0c982b..2d2444417e2b2d9281754d113f2b073034e27739 100644
> > --- a/drivers/net/wireless/ath/ath12k/wmi.c
> > +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> > @@ -7626,6 +7626,63 @@ static int ath12k_wmi_pull_fw_stats(struct ath12k_base *ab, struct sk_buff *skb,
> >   				   &parse);
> >   }
> > +static void ath12k_wmi_fw_stats_process(struct ath12k *ar,
> > +					struct ath12k_fw_stats *stats)
> > +{
> > +	struct ath12k_base *ab = ar->ab;
> > +	struct ath12k_pdev *pdev;
> > +	bool is_end;
> > +	static unsigned int num_vdev, num_bcn;
> > +	size_t total_vdevs_started = 0;
> > +	int i;
> > +
> > +	if (stats->stats_id == WMI_REQUEST_VDEV_STAT) {
> > +		if (list_empty(&stats->vdevs)) {
> > +			ath12k_warn(ab, "empty vdev stats");
> > +			return;
> > +		}
> > +		/* FW sends all the active VDEV stats irrespective of PDEV,
> > +		 * hence limit until the count of all VDEVs started
> > +		 */
> > +		rcu_read_lock();
> > +		for (i = 0; i < ab->num_radios; i++) {
> > +			pdev = rcu_dereference(ab->pdevs_active[i]);
> > +			if (pdev && pdev->ar)
> > +				total_vdevs_started += pdev->ar->num_started_vdevs;
> > +		}
> > +		rcu_read_unlock();
> > +
> > +		is_end = ((++num_vdev) == total_vdevs_started);
> > +
> > +		list_splice_tail_init(&stats->vdevs,
> > +				      &ar->fw_stats.vdevs);
> > +
> > +		if (is_end) {
> > +			ar->fw_stats.fw_stats_done = true;
> > +			num_vdev = 0;
> > +		}
> > +		return;
> > +	}
> > +	if (stats->stats_id == WMI_REQUEST_BCN_STAT) {
> > +		if (list_empty(&stats->bcn)) {
> > +			ath12k_warn(ab, "empty beacon stats");
> > +			return;
> > +		}
> > +		/* Mark end until we reached the count of all started VDEVs
> > +		 * within the PDEV
> > +		 */
> > +		is_end = ((++num_bcn) == ar->num_started_vdevs);
> > +
> > +		list_splice_tail_init(&stats->bcn,
> > +				      &ar->fw_stats.bcn);
> > +
> > +		if (is_end) {
> > +			ar->fw_stats.fw_stats_done = true;
> > +			num_bcn = 0;
> > +		}
> > +	}
> > +}
> > +
> >   static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *skb)
> >   {
> >   	struct ath12k_fw_stats stats = {};
> > @@ -7655,19 +7712,15 @@ static void ath12k_update_stats_event(struct ath12k_base *ab, struct sk_buff *sk
> >   	spin_lock_bh(&ar->data_lock);
> > -	/* WMI_REQUEST_PDEV_STAT can be requested via .get_txpower mac ops or via
> > -	 * debugfs fw stats. Therefore, processing it separately.
> > -	 */
> > +	/* Handle WMI_REQUEST_PDEV_STAT status update */
> >   	if (stats.stats_id == WMI_REQUEST_PDEV_STAT) {
> >   		list_splice_tail_init(&stats.pdevs, &ar->fw_stats.pdevs);
> >   		ar->fw_stats.fw_stats_done = true;
> >   		goto complete;
> >   	}
> > -	/* WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT are currently requested only
> > -	 * via debugfs fw stats. Hence, processing these in debugfs context.
> > -	 */
> > -	ath12k_debugfs_fw_stats_process(ar, &stats);
> > +	/* Handle WMI_REQUEST_VDEV_STAT and WMI_REQUEST_BCN_STAT updates. */
> > +	ath12k_wmi_fw_stats_process(ar, &stats);
> >   complete:
> >   	complete(&ar->fw_stats_complete);
> > 
> 
> 
> This look fine to me, Thanks for fixing this.
> 
> Apart from this we may also have to free up the stats buffer list maintained
> when the stats is requested out of debugfs (like ath12k_mac_op_get_txpower()
> and ath12k_mac_op_sta_statistics()) once its scope of usage is done, else
> the memory will be held untill next fw stats request or module unload.
> 

I agree with this. In fact it seems to me that the majority of [1]
should be considered for ath12k as well (and Jeff acknowledged the
same).

The purpose of this patch was solely to deal with the regression from
the previous behavior introduced in v6.16-rc1, causing my X Elite laptop
to idle about 10C warmer. (Afaict neither distros or upstream arm64
defconfig has ATH12K_DEBUG enabled)

The "also fix X, Y, Z" would at least be separate patches, and could be
applied either to -rc or v6.17 on top of something like this.

[1] https://lore.kernel.org/ath11k/20250220082448.31039-1-quic_bqiang@quicinc.com/

Regards,
Bjorn

> -- 
> --
> Ramesh
> 
> 

