Return-Path: <linux-wireless+bounces-37534-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tmSZM1TlJmpdmgIAu9opvQ
	(envelope-from <linux-wireless+bounces-37534-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 17:52:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9436585E2
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 17:52:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fRs+R4j7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37534-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37534-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853CC3511A5B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB603F2109;
	Mon,  8 Jun 2026 15:18:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92D2DE6E6;
	Mon,  8 Jun 2026 15:18:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931918; cv=none; b=Oab7fH1qWCq8GrRDueksgly1/5OPpy0biGcm6dAdlA987xZWYthmmpplIx2jCgrX+Lk5CWc4mJt3u282+ae/ZhPRvDQA7Fp22sWSrDyURicTvdBYiyt9RCriqISW+VW2JWr7s7FPdpaAxyalm6ASRgG7jR15xgR92i0ZzvjGJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931918; c=relaxed/simple;
	bh=rueb+9AYc2E2/iUiDTkPBeaIesWk6ngSanqF7eTX95s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gzd3LKbM4+o19+TQ863v8mUi24JXLyDWLwLDceGFTH/sRlk4aPJxITbeFIo037xHM1zc52PNCHkf8XJma5fTo1kb/RqGWCgbqs/lAiYN2Ws4GsJns5K7ZHy28iSVnaHd0fsDlGVubYutVXKvYu1Orm5jYWtY8sEmixLLKVLEc6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRs+R4j7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702691F00898;
	Mon,  8 Jun 2026 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780931916;
	bh=sTLCZKrnRtrIRJXJzO4FzQsnVEhHnjPYOb7yuw7wgNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fRs+R4j7/J1Yn4/cFT+KTS79N/Xda5tsPWkpeG2flEfh2ea4eOBOkoB7ARKhDyB4p
	 xYo/mNKG5ERQfWzfjw5FMPAvTEPzBlLTOO+6O+NHI/goeAdhvnCCZs16Cq78YCUPSa
	 8CwHyh50xzXgT+8mxPOvYIKiN9cUzt06Wp8JnYlnsGcZMqdOqFKx01/bpz3JrObu5V
	 3OvPqn/HrnTbyd3vyY5ggAJXjYrhGluVABNtSZAwo0q/G01HaWB6C/4JsDDrA7IzhT
	 VrDxF9G/9u7LhpGwET19n9BD9+BjGbMhQfZxSvQJfd2gHjdpQmVWeagA/qMkOPfDF9
	 uKHR34IqaOPQA==
Date: Mon, 8 Jun 2026 10:18:35 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, devicetree@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-bluetooth@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/7] arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
Message-ID: <20260608151835.GA2707238-robh@kernel.org>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37534-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com,vger.kernel.org,lists.infradead.org,bgdev.pl];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B9436585E2

On Mon, Jun 08, 2026 at 09:59:18AM +0300, Dmitry Baryshkov wrote:
> The SM8350 HDK has an onboard WCN6851 WiFi/BT chip, which for a long
> time was not supported. Bring up different pieces required to enable
> this SoC.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Bumped num_vdevs to 4 to follow other similar devices (Jeff)
> - Link to v1: https://patch.msgid.link/20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com
> 
> ---
> Dmitry Baryshkov (7):
>       PCI: qcom: fix parsing of PERST# in the legacy case
>       wifi: ath11k: enable support for WCN6851
>       regulator: dt-bindings: qcom,qca6390-pmu: document WCN6851
>       dt-bindings: bluetooth: qcom,wcn6855-bt: document WCN6851
>       arm64: dts: qcom: sm8350: expand UART18 to 4 pins config
>       arm64: dts: qcom: sm8350: modernize PCIe entries
>       arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip

Before adding new devices, can you (Qcom) fix the all the existing DT 
warnings related to QCom WiFi/BT:

      6 (qcom,wcn6855-bt): 'vddrfa1p7-supply' is a required property
      6 (qcom,wcn6855-bt): Unevaluated properties are not allowed ('vddrfa1p8-supply' was unexpected)
      2 (qcom,wcn6855-bt): 'vddwlmx-supply' is a required property
      2 (qcom,wcn6855-bt): 'vddwlcx-supply' is a required property
      2 (qcom,wcn6855-bt): 'vddbtcmx-supply' is a required property
      2 (qcom,wcn6855-bt): 'vddaon-supply' is a required property
      2 (pci17cb,1103): 'vddwlmx-supply' is a required property
      2 (pci17cb,1103): 'vddwlcx-supply' is a required property
      2 (pci17cb,1103): 'vddrfacmn-supply' is a required property
      2 (pci17cb,1103): 'vddrfa1p8-supply' is a required property
      2 (pci17cb,1103): 'vddrfa1p2-supply' is a required property
      2 (pci17cb,1103): 'vddrfa0p8-supply' is a required property
      2 (pci17cb,1103): 'vddpcie1p8-supply' is a required property
      2 (pci17cb,1103): 'vddpcie0p9-supply' is a required property
      2 (pci17cb,1103): 'vddaon-supply' is a required property

Rob

