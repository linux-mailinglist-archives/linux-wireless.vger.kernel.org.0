Return-Path: <linux-wireless+bounces-26556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC2B31008
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 09:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2BD9175FB1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 07:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB12236FD;
	Fri, 22 Aug 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="dHfgWtgJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CED1632C8
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846873; cv=none; b=Hx5MNXB8FeDvqHSUFl8EgVO878BPo7ctME68Tp87LxzjEo+3gY3mmsvf47ktBNYrsc8k84EjI/H4A9dvy6sE6D1yePAuWypHr87PwymZUuyt4Hf5H2UXGu8oqDIwZpiNpzKi305x9y41sx3Ki5stNtyvku/fhUlISfU3ABrXDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846873; c=relaxed/simple;
	bh=K3JGXfg5ueJ9Trt7ntIKgcOSsX63ZzfBfJETVGNzTvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj/FcpTAGjs/Qwxx562e5JNXRVYUVHBngn78OP70mN38arTnxrdxlwsh1N8bGy8u5tpjkZvPv9eRxgyH4fRNhqZkRAseyyQMJ7jvTGkSeJkaAp0fi4eK83QNFIUmHFCocQa8ovPOTay8GVGURGxW5WN7PRhaCWYhwxy6kfhmVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=dHfgWtgJ; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 44574 invoked from network); 22 Aug 2025 09:14:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1755846860; bh=LqtWAHV/ZOPkZ5sTWV89Ib8PULJOZ58k/apc29IXCpY=;
          h=From:To:Cc:Subject;
          b=dHfgWtgJ9z8ShrsdQfUMjCHhjtGJ+Nx7P1/FPK3Wlip7ptGw2tO+KMw/dkO5k1gae
           tyyDY7DBM0IwfzL36Odt47iM7hjLUAtpmMEZ87vYykM1Rn2EOgcXZFClSYVKitUEo+
           99wpF/VBAr9cQu1BvDxZWijaSqgovPZdT4F4PAgDjQ5SUVo3scgsd8bJ+QfpobAFnz
           ertwy404fN3wTbrRz4Z1Onem52GBeebj2TVC0FJkmi3Bn5CytRJnGtYzkta0Rn0oLH
           DQEYW+kHC7XcKj+hYIBQ7c+W8yq8Leo1Fp/SFoios6DcyA6DGp8c2J34HJAYlE8Ihy
           RiTZ2Fl/2zVEA==
Received: from 89-64-9-131.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.131])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gustavoars@kernel.org>; 22 Aug 2025 09:14:20 +0200
Date: Fri, 22 Aug 2025 09:14:20 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iwlegacy: Remove unused structs and avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250822071420.GA46129@wp.pl>
References: <aJl7TxeWgLdEKWhg@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJl7TxeWgLdEKWhg@kspp>
X-WP-MailID: aa1691429c86c2fecbca16863494ab9c
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [ETJx]                               

On Mon, Aug 11, 2025 at 02:10:39PM +0900, Gustavo A. R. Silva wrote:
> Remove unused structures and avoid the following
> -Wflex-array-member-not-at-end warnings:
> 
> drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h:68:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h:60:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  .../wireless/intel/iwlegacy/iwl-spectrum.h    | 24 -------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> index 1e8ab704dbfb..f00eb878b94b 100644
> --- a/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> +++ b/drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h
> @@ -50,28 +50,4 @@ struct ieee80211_measurement_params {
>  	__le16 duration;
>  } __packed;
>  
> -struct ieee80211_info_element {
> -	u8 id;
> -	u8 len;
> -	u8 data[];
> -} __packed;
> -
> -struct ieee80211_measurement_request {
> -	struct ieee80211_info_element ie;
> -	u8 token;
> -	u8 mode;
> -	u8 type;
> -	struct ieee80211_measurement_params params[];
> -} __packed;
> -
> -struct ieee80211_measurement_report {
> -	struct ieee80211_info_element ie;
> -	u8 token;
> -	u8 mode;
> -	u8 type;
> -	union {
> -		struct ieee80211_basic_report basic[0];
> -	} u;
> -} __packed;
> -
>  #endif
> -- 
> 2.43.0
> 

