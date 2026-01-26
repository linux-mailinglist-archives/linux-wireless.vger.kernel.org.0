Return-Path: <linux-wireless+bounces-31166-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMEjNskod2lzcwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31166-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 09:41:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCA0858F7
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 09:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40A653008E11
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9457C2C027A;
	Mon, 26 Jan 2026 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTBnKJlJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D41A3166
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416901; cv=none; b=t8fwKkFWEp75mIVyR2KDEWq5YFLQAifzB7N/2Ks3Zl1K6MODo2C8tcpLV+BroEfyVdL+3H35kUjVKkj5dEBa4WPUveKg58O6l4+dpbYYdPpQFWi1kPS3sA37zek2Ed8Rt48uq8lUQMgJ1UY8+oA90Zq/n32BZsi69JBNprotLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416901; c=relaxed/simple;
	bh=JD6c3Uc0L4ku75ADp9FotLO+1jTyeq0tXK1pUkS4yxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvVf8zD164f48fg251p7LvJuLusuUQ7cooHluvwPsRS1WS3RdDJEcxsp+LYVsXNzdCA//y5i5DIGJ2E2HsC4ZfXdBfo0uj9ycjcZqeuuXIpOsDCfqbzrKVM+u/qnXp4vLqoQx/L9G0uy05A1omKb0l3NKMTbRBjlNNS/YarT7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTBnKJlJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4327555464cso2802488f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 00:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769416897; x=1770021697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KhhFEDEx9PM21ZgT9lc8zLuiewpJ8PQCrIIeUpW6xUw=;
        b=hTBnKJlJrrLmiiFDevit1V0K2vOWdLGEtxpN/PpImsRmpJgnlEclaq1jszc0uAmU3y
         I61zL4Z8AjbYa+niWsHg9JSTmRfR3Qe2mE+c0XGt1oyELMhi347DhenKCdHFTOQ1ryzF
         YGsJ0yAeC+yzmPgQy/3NgnN0BZ7S8jvZxBiBv5DpqkCFP58cqy2ad40IEx/YCeoK4HCr
         gW6hLWgpqlxvsfXO6KTBprrs1uw3tiVRqGiDbiqN2F4dajIQDxiK4Y0RRCi5xNs+TQfn
         sm2FdsACO1h5qjLqvuGJybtwPIg39XPz7hG8HzWYMlwzj3VdtSG6wlDbOrh/6CecgOQx
         civA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769416897; x=1770021697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhhFEDEx9PM21ZgT9lc8zLuiewpJ8PQCrIIeUpW6xUw=;
        b=Hmh3Qv5m+aGwVO0dp69OnpLmAALm0yj9MAlLB5chndqc6vm+XoyDjVerBVbeO3X5Su
         JMOn7t/IF7wwMSBrH8Bw5QD2WYO0oXDv6cD5TUd7wsyeoq+PVI3mA8SkC+O+DjfYwliC
         HCw9JcB5lrcae2vq+zVaHUVwgXshxWLgOLv6mswyzWERTH0RIrJN6peQGOf0KtY26tU+
         sIt2RLfAcH/9GJWTfesw8AWOESLo2rHJ46wNFJewYyirf6vbAU+g4q2rDuNvOGfcOs9F
         ygfyM9rjxgySGT9Bg//URRq1N0FgCb+Uyd3nWrDGBtvhW7AXwkEHR1q/1Rxsuppx0ADf
         k3qg==
X-Forwarded-Encrypted: i=1; AJvYcCUF+HxgfCyzYDw5HJ6ZzB3Q/nmiK1WS+WzEj2nVKBBowGV0mTBSR/MwY3zV5WcyTFFt3Xq52P5zXRmpu4+/Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZ8xOTRws4Ie7zzQIJXWlLdxlfJPhYNAncfZuWmbzcQmXInXg
	E3h8hpcnBlpN+xxKmb3c9wz74hDYn8q+EYiD4777tCc6Y2kYTLPNmtFe
X-Gm-Gg: AZuq6aIeiAGAcMl1bTL9gKE4InJaWNEQYf9nvieI4Up1bA4enSYMlbVKqqTCuPCQivT
	4JX0aWeGIiUt243cbRqepmozUdoXAdLTiHzfuDHRad2dhE6Oc8pofeSoRhm0b5va1a+IUloR18y
	1WKbzUR/6yjB0PcrnqFxacpUENvRF4ajMFAEclvOuCh+fOIfImwn+duDTrKKcCdug2qFaKZPFkF
	Pb1QiXquDf+OeNbhjDQKmFSCLiw5XBbjN53AyMaLsU3n3LNAzhbbYQaJnPqzFE9nVY+2XzWd/Ra
	zMrmCtnvkseq4HoNxmL5RB0HXHFUhaCUjeV70xDEbFUv1D2tBtCewRPSu8JerE5TN60DLvDQph/
	YxyJqbPLAo4o20vNA2N/d7NyXfFpYsk2bLEvKncLAwZqgg+qLQsrFg8iPy/r9NuJQaSVvf1VZh0
	+e8KiUUzs+Cf7M4pQKnV9gaF4UqK6KdyamWw==
X-Received: by 2002:a05:6000:2010:b0:430:fb6d:1442 with SMTP id ffacd0b85a97d-435ca3a940emr6983816f8f.62.1769416896888;
        Mon, 26 Jan 2026 00:41:36 -0800 (PST)
Received: from debian.local ([2a0a:ef40:e94:5d01:a218:5589:9f9c:4f52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c8efsm28843917f8f.42.2026.01.26.00.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 00:41:36 -0800 (PST)
Date: Mon, 26 Jan 2026 08:41:32 +0000
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>,
	"linux-intel-wifi@intel.com" <linux-intel-wifi@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Revert "wifi: iwlwifi: trans: remove STATUS_SUSPENDED"
Message-ID: <aXcovK8uhsiaHumT@debian.local>
References: <20260125233335.6875-1-chris.bainbridge@gmail.com>
 <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DM3PPF63A6024A93B1437A144E82CC38B7AA393A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31166-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisbainbridge@gmail.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FCA0858F7
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 07:15:54AM +0000, Korenblit, Miriam Rachel wrote:
>=20
> Hi Chris, could you please provide the full log?
>=20
> Miri

Sure, for 6.18.0 see https://lore.kernel.org/linux-wireless/aTDoDiD55qlUZ0p=
n@debian.local/

For a more recent commit, this time with KASAN enabled:

[ 3706.202608] ACPI: EC: interrupt unblocked
[ 3706.274784] [drm] PCIE GART of 1024M enabled.
[ 3706.274793] [drm] PTB located at 0x000000F41FC00000
[ 3706.274842] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[ 3706.276624] amdgpu 0000:03:00.0: amdgpu: dpm has been disabled
[ 3706.277785] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[ 3706.370297] [drm] DM_MST: Differing MST start on aconnector: 000000001fd=
f7997 [id: 116]
[ 3706.383907] nvme nvme0: 8/0/0 default/read/poll queues
[ 3706.594989] usb 1-3: reset high-speed USB device number 3 using xhci_hcd
[ 3706.935077] usb 1-1: reset high-speed USB device number 2 using xhci_hcd
[ 3707.315021] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on h=
ub 0
[ 3707.315029] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng=
 1 on hub 0
[ 3707.315032] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng=
 4 on hub 0
[ 3707.315034] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng=
 5 on hub 0
[ 3707.315036] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng=
 6 on hub 0
[ 3707.315038] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng=
 7 on hub 0
[ 3707.315039] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng=
 8 on hub 0
[ 3707.315041] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng=
 9 on hub 0
[ 3707.315043] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng=
 10 on hub 0
[ 3707.315045] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv en=
g 11 on hub 0
[ 3707.315047] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on=
 hub 8
[ 3707.315049] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 =
on hub 8
[ 3707.315051] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4=
 on hub 8
[ 3707.315053] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5=
 on hub 8
[ 3707.315055] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6=
 on hub 8
[ 3707.448025] usb 1-1.5: reset high-speed USB device number 6 using xhci_h=
cd
[ 3707.636137] usb 1-1.3: reset high-speed USB device number 4 using xhci_h=
cd
[ 3707.655263] iwlwifi 0000:01:00.0: Error sending SYSTEM_STATISTICS_CMD: t=
ime out after 2000ms.
[ 3707.655322] iwlwifi 0000:01:00.0: Current CMD queue read_ptr 6126 write_=
ptr 6127
[ 3707.656132] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 3707.656135] iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 6
[ 3707.656139] iwlwifi 0000:01:00.0: Loaded firmware version: 89.7f71c7f4.0=
 ty-a0-gf-a0-89.ucode
[ 3707.656144] iwlwifi 0000:01:00.0: 0x01000071 | ADVANCED_SYSASSERT       =
  =20
[ 3707.656148] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[ 3707.656151] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 3707.656153] iwlwifi 0000:01:00.0: 0x004DAD04 | branchlink2
[ 3707.656156] iwlwifi 0000:01:00.0: 0x004D092A | interruptlink1
[ 3707.656159] iwlwifi 0000:01:00.0: 0x004D092A | interruptlink2
[ 3707.656161] iwlwifi 0000:01:00.0: 0x00016AD2 | data1
[ 3707.656164] iwlwifi 0000:01:00.0: 0x00000010 | data2
[ 3707.656167] iwlwifi 0000:01:00.0: 0x00000000 | data3
[ 3707.656169] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[ 3707.656172] iwlwifi 0000:01:00.0: 0xDA85A336 | tsf low
[ 3707.656175] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[ 3707.656177] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 3707.656180] iwlwifi 0000:01:00.0: 0xDA872EF8 | time gp2
[ 3707.656182] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 3707.656185] iwlwifi 0000:01:00.0: 0x00000059 | uCode version major
[ 3707.656188] iwlwifi 0000:01:00.0: 0x7F71C7F4 | uCode version minor
[ 3707.656190] iwlwifi 0000:01:00.0: 0x00000000 | hw version
[ 3707.656193] iwlwifi 0000:01:00.0: 0x00000000 | board version
[ 3707.656196] iwlwifi 0000:01:00.0: 0x804AF800 | hcmd
[ 3707.656198] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[ 3707.656201] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[ 3707.656203] iwlwifi 0000:01:00.0: 0x48F04002 | isr2
[ 3707.656206] iwlwifi 0000:01:00.0: 0x00C3000C | isr3
[ 3707.656208] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 3707.656211] iwlwifi 0000:01:00.0: 0x00C90103 | last cmd Id
[ 3707.656214] iwlwifi 0000:01:00.0: 0x00016AD2 | wait_event
[ 3707.656216] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 3707.656219] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 3707.656221] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 3707.656224] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 3707.656226] iwlwifi 0000:01:00.0: 0x00000018 | lmpm_pmg_sel
[ 3707.656229] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[ 3707.656231] iwlwifi 0000:01:00.0: 0x00003054 | flow_handler
[ 3707.656566] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 3707.656568] iwlwifi 0000:01:00.0: Transport status: 0x00000042, valid: 7
[ 3707.656571] iwlwifi 0000:01:00.0: 0x211010B8 | ADVANCED_SYSASSERT
[ 3707.656574] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 3707.656577] iwlwifi 0000:01:00.0: 0x804838BE | umac branchlink2
[ 3707.656580] iwlwifi 0000:01:00.0: 0xC00814E0 | umac interruptlink1
[ 3707.656582] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[ 3707.656585] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[ 3707.656587] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[ 3707.656590] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[ 3707.656593] iwlwifi 0000:01:00.0: 0x00000059 | umac major
[ 3707.656595] iwlwifi 0000:01:00.0: 0x7F71C7F4 | umac minor
[ 3707.656598] iwlwifi 0000:01:00.0: 0xDA872EF3 | frame pointer
[ 3707.656600] iwlwifi 0000:01:00.0: 0xC0886C04 | stack pointer
[ 3707.656603] iwlwifi 0000:01:00.0: 0x00ED01D3 | last host cmd
[ 3707.656606] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 3707.656926] iwlwifi 0000:01:00.0: IML/ROM dump:
[ 3707.656928] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[ 3707.657055] iwlwifi 0000:01:00.0: 0x00008E8A | IML/ROM data1
[ 3707.657184] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[ 3707.657309] iwlwifi 0000:01:00.0: Fseq Registers:
[ 3707.657593] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[ 3707.657655] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_TOP_INIT_VERSION
[ 3707.657717] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[ 3707.657780] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[ 3707.657842] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[ 3707.657903] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 3707.657965] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[ 3707.658027] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[ 3707.658089] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[ 3707.658155] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[ 3707.658219] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[ 3707.658283] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[ 3707.658345] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[ 3707.658406] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[ 3707.658468] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[ 3707.658529] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[ 3707.658894] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0xc0080040
[ 3707.658956] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[ 3707.660021] iwlwifi 0000:01:00.0: iwl_mvm_check_rt_status failed, device=
 is gone during suspend
[ 3707.660495] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 3707.660498] iwlwifi 0000:01:00.0: Transport status: 0x00000642, valid: 6
[ 3707.660501] iwlwifi 0000:01:00.0: Loaded firmware version: 89.7f71c7f4.0=
 ty-a0-gf-a0-89.ucode
[ 3707.660504] iwlwifi 0000:01:00.0: 0x01000071 | ADVANCED_SYSASSERT       =
  =20
[ 3707.660507] iwlwifi 0000:01:00.0: 0x000002F0 | trm_hw_status0
[ 3707.660510] iwlwifi 0000:01:00.0: 0x00000000 | trm_hw_status1
[ 3707.660512] iwlwifi 0000:01:00.0: 0x004DAD04 | branchlink2
[ 3707.660515] iwlwifi 0000:01:00.0: 0x004D092A | interruptlink1
[ 3707.660518] iwlwifi 0000:01:00.0: 0x004D092A | interruptlink2
[ 3707.660521] iwlwifi 0000:01:00.0: 0x00016AD2 | data1
[ 3707.660523] iwlwifi 0000:01:00.0: 0x00000010 | data2
[ 3707.660526] iwlwifi 0000:01:00.0: 0x00000000 | data3
[ 3707.660529] iwlwifi 0000:01:00.0: 0x00000000 | beacon time
[ 3707.660531] iwlwifi 0000:01:00.0: 0xDA85A336 | tsf low
[ 3707.660534] iwlwifi 0000:01:00.0: 0x00000000 | tsf hi
[ 3707.660537] iwlwifi 0000:01:00.0: 0x00000000 | time gp1
[ 3707.660539] iwlwifi 0000:01:00.0: 0xDA872EF8 | time gp2
[ 3707.660542] iwlwifi 0000:01:00.0: 0x00000001 | uCode revision type
[ 3707.660545] iwlwifi 0000:01:00.0: 0x00000059 | uCode version major
[ 3707.660547] iwlwifi 0000:01:00.0: 0x7F71C7F4 | uCode version minor
[ 3707.660550] iwlwifi 0000:01:00.0: 0x00000000 | hw version
[ 3707.660553] iwlwifi 0000:01:00.0: 0x00000000 | board version
[ 3707.660555] iwlwifi 0000:01:00.0: 0x804AF800 | hcmd
[ 3707.660558] iwlwifi 0000:01:00.0: 0x00020000 | isr0
[ 3707.660561] iwlwifi 0000:01:00.0: 0x00000000 | isr1
[ 3707.660563] iwlwifi 0000:01:00.0: 0x48F04002 | isr2
[ 3707.660566] iwlwifi 0000:01:00.0: 0x00C3000C | isr3
[ 3707.660568] iwlwifi 0000:01:00.0: 0x00000000 | isr4
[ 3707.660571] iwlwifi 0000:01:00.0: 0x00C90103 | last cmd Id
[ 3707.660574] iwlwifi 0000:01:00.0: 0x00016AD2 | wait_event
[ 3707.660576] iwlwifi 0000:01:00.0: 0x00000000 | l2p_control
[ 3707.660579] iwlwifi 0000:01:00.0: 0x00000000 | l2p_duration
[ 3707.660581] iwlwifi 0000:01:00.0: 0x00000000 | l2p_mhvalid
[ 3707.660584] iwlwifi 0000:01:00.0: 0x00000000 | l2p_addr_match
[ 3707.660587] iwlwifi 0000:01:00.0: 0x00000018 | lmpm_pmg_sel
[ 3707.660589] iwlwifi 0000:01:00.0: 0x00000000 | timestamp
[ 3707.660592] iwlwifi 0000:01:00.0: 0x00003054 | flow_handler
[ 3707.660931] iwlwifi 0000:01:00.0: Start IWL Error Log Dump:
[ 3707.660934] iwlwifi 0000:01:00.0: Transport status: 0x00000642, valid: 7
[ 3707.660937] iwlwifi 0000:01:00.0: 0x211010B8 | ADVANCED_SYSASSERT
[ 3707.660940] iwlwifi 0000:01:00.0: 0x00000000 | umac branchlink1
[ 3707.660943] iwlwifi 0000:01:00.0: 0x804838BE | umac branchlink2
[ 3707.660945] iwlwifi 0000:01:00.0: 0xC00814E0 | umac interruptlink1
[ 3707.660948] iwlwifi 0000:01:00.0: 0x00000000 | umac interruptlink2
[ 3707.660951] iwlwifi 0000:01:00.0: 0x00000002 | umac data1
[ 3707.660953] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data2
[ 3707.660956] iwlwifi 0000:01:00.0: 0xDEADBEEF | umac data3
[ 3707.660959] iwlwifi 0000:01:00.0: 0x00000059 | umac major
[ 3707.660961] iwlwifi 0000:01:00.0: 0x7F71C7F4 | umac minor
[ 3707.660964] iwlwifi 0000:01:00.0: 0xDA872EF3 | frame pointer
[ 3707.660967] iwlwifi 0000:01:00.0: 0xC0886C04 | stack pointer
[ 3707.660970] iwlwifi 0000:01:00.0: 0x00ED01D3 | last host cmd
[ 3707.660972] iwlwifi 0000:01:00.0: 0x00000000 | isr status reg
[ 3707.661290] iwlwifi 0000:01:00.0: IML/ROM dump:
[ 3707.661293] iwlwifi 0000:01:00.0: 0x00000B03 | IML/ROM error/state
[ 3707.661418] iwlwifi 0000:01:00.0: 0x00008E8A | IML/ROM data1
[ 3707.661546] iwlwifi 0000:01:00.0: 0x00000090 | IML/ROM WFPM_AUTH_KEY_0
[ 3707.661669] iwlwifi 0000:01:00.0: Fseq Registers:
[ 3707.661905] iwlwifi 0000:01:00.0: 0x60000000 | FSEQ_ERROR_CODE
[ 3707.661967] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_TOP_INIT_VERSION
[ 3707.662029] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_CNVIO_INIT_VERSION
[ 3707.662091] iwlwifi 0000:01:00.0: 0x0000A652 | FSEQ_OTP_VERSION
[ 3707.662153] iwlwifi 0000:01:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
[ 3707.662214] iwlwifi 0000:01:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 3707.662276] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVI_ID
[ 3707.662338] iwlwifi 0000:01:00.0: 0x00400410 | FSEQ_CNVR_ID
[ 3707.662401] iwlwifi 0000:01:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
[ 3707.662466] iwlwifi 0000:01:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
[ 3707.662541] iwlwifi 0000:01:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_D=
IG_DCDC_VTRIM
[ 3707.662770] iwlwifi 0000:01:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_A=
CTIVE_VDIG_MIRROR
[ 3707.662832] iwlwifi 0000:01:00.0: 0x00080009 | FSEQ_PREV_CNVIO_INIT_VERS=
ION
[ 3707.662893] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_WIFI_FSEQ_VERSION
[ 3707.662956] iwlwifi 0000:01:00.0: 0x00440007 | FSEQ_BT_FSEQ_VERSION
[ 3707.663017] iwlwifi 0000:01:00.0: 0x000000E6 | FSEQ_CLASS_TP_VERSION
[ 3707.663203] iwlwifi 0000:01:00.0: UMAC CURRENT PC: 0xc0080040
[ 3707.663267] iwlwifi 0000:01:00.0: LMAC1 CURRENT PC: 0xd0
[ 3707.663331] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[ 3708.074557] usb 1-1.3.5: reset high-speed USB device number 10 using xhc=
i_hcd
[ 3708.225056] iwlwifi 0000:01:00.0: WRT: Collecting data: ini trigger 4 fi=
red (delay=3D0ms).
[ 3708.270765] usb 1-1.3.4: reset high-speed USB device number 8 using xhci=
_hcd
[ 3708.801001] usb 1-1.3.2: reset high-speed USB device number 7 using xhci=
_hcd
[ 3709.034210] iwlwifi 0000:01:00.0: WFPM_UMAC_PD_NOTIFICATION: 0x20
[ 3709.034301] iwlwifi 0000:01:00.0: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[ 3709.034374] iwlwifi 0000:01:00.0: WFPM_AUTH_KEY_0: 0x90
[ 3709.034454] iwlwifi 0000:01:00.0: CNVI_SCU_SEQ_DATA_DW9: 0x0
[ 3709.257815] usb 1-1.3.2.1: reset full-speed USB device number 9 using xh=
ci_hcd
[ 3709.447487] usb 1-1.3.2.3: reset full-speed USB device number 11 using x=
hci_hcd
[ 3709.635731] usb 1-1.3.2.4: reset high-speed USB device number 12 using x=
hci_hcd
[ 3710.026286] usb 1-1.3.2.3.1: reset low-speed USB device number 13 using =
xhci_hcd
[ 3710.566575] usb 1-1.3.2.3.4: reset low-speed USB device number 14 using =
xhci_hcd
[ 3710.931672] OOM killer enabled.
[ 3710.931678] Restarting tasks: Starting
[ 3710.932001] usb 1-4: USB disconnect, device number 15
[ 3710.938201] Restarting tasks: Done
[ 3710.938271] efivarfs: resyncing variable state
[ 3710.957965] efivarfs: finished resyncing variable state
[ 3710.958074] random: crng reseeded on system resumption
[ 3711.059848] PM: suspend exit
[ 3711.094289] usb 1-4: new full-speed USB device number 16 using xhci_hcd
[ 3711.107258] Oops: general protection fault, probably for non-canonical a=
ddress 0xdffffc0000000000: 0000 [#1] SMP KASAN
[ 3711.107285] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000=
000000007]
[ 3711.107297] CPU: 1 UID: 0 PID: 1560 Comm: wpa_supplicant Not tainted 6.1=
9.0-rc6-00339-g62085877ae65 #373 PREEMPT(voluntary)=20
[ 3711.107307] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.17 12/18/2024
[ 3711.107314] RIP: 0010:iwl_mvm_get_wd_timeout+0x10a/0x180 [iwlmvm]
[ 3711.107379] Code: df 48 c1 ea 03 80 3c 02 00 75 6d 49 8b 85 30 01 00 00 =
48 0f ba e0 26 73 27 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 <0f=
> b6 04 02 84 c0 74 04 3c 03 7e 21 31 c0 83 7d 00 03 44 0f 44 e0
[ 3711.107388] RSP: 0018:ffff888128caeb68 EFLAGS: 00010256
[ 3711.107399] RAX: dffffc0000000000 RBX: ffff88812864c140 RCX: ffffffffc56=
a2bf4
[ 3711.107404] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881286=
4c140
[ 3711.107410] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed10250=
c9828
[ 3711.107414] R10: ffff88812864c147 R11: 0000000000000002 R12: 00000000000=
02710
[ 3711.107418] R13: ffff88812864c010 R14: dffffc0000000000 R15: ffff888136f=
fb0e8
[ 3711.107423] FS:  00007f76a0ff9880(0000) GS:ffff8883e7d30000(0000) knlGS:=
0000000000000000
[ 3711.107430] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3711.107434] CR2: 0000357c0c75f000 CR3: 00000001215c2000 CR4: 00000000007=
50ef0
[ 3711.107440] PKRU: 55555554
[ 3711.107445] Call Trace:
[ 3711.107458]  <TASK>
[ 3711.107466]  iwl_mvm_realloc_queues_after_restart+0x96/0x5a0 [iwlmvm]
[ 3711.107499]  ? kasan_save_stack+0x3b/0x50
[ 3711.107521]  ? kasan_save_stack+0x2c/0x50
[ 3711.107526]  ? kasan_save_track+0x10/0x30
[ 3711.107534]  ? sta_info_insert_rcu+0x6fc/0x22e0 [mac80211]
[ 3711.107688]  ? iwl_mvm_sta_alloc_queue_tvqm.isra.0+0x2f0/0x2f0 [iwlmvm]
[ 3711.107720]  ? genl_family_rcv_msg_doit+0x1dd/0x2b0
[ 3711.107735]  ? lock_is_held_type+0xd5/0x130
[ 3711.107751]  iwl_mvm_mld_add_sta+0x499/0xf60 [iwlmvm]
[ 3711.107781]  iwl_mvm_mac_sta_state_common+0x390/0x2590 [iwlmvm]
[ 3711.107814]  drv_sta_state+0x288/0x16b0 [mac80211]
[ 3711.107934]  sta_info_insert_rcu+0x11e5/0x22e0 [mac80211]
[ 3711.108025]  ? drv_link_info_changed+0x3ea/0x6c0 [mac80211]
[ 3711.108113]  sta_info_insert+0xb/0x70 [mac80211]
[ 3711.108197]  ieee80211_prep_connection+0xc44/0x1300 [mac80211]
[ 3711.108294]  ieee80211_mgd_auth+0xa28/0x1530 [mac80211]
[ 3711.108383]  ? ieee80211_mlme_notify_scan_completed+0x430/0x430 [mac8021=
1]
[ 3711.108466]  ? __local_bh_enable_ip+0xab/0x130
[ 3711.108479]  ? rcu_is_watching+0x11/0xb0
[ 3711.108494]  ? __cfg80211_get_bss+0x687/0xcf0 [cfg80211]
[ 3711.108646]  ? lock_is_held_type+0xd5/0x130
[ 3711.108662]  cfg80211_mlme_auth+0x457/0x8e0 [cfg80211]
[ 3711.108751]  nl80211_authenticate+0xa25/0x1050 [cfg80211]
[ 3711.108836]  ? nl80211_parse_key+0xe80/0xe80 [cfg80211]
[ 3711.108923]  ? nl80211_pre_doit+0x50a/0x7a0 [cfg80211]
[ 3711.109000]  genl_family_rcv_msg_doit+0x1dd/0x2b0
[ 3711.109017]  ? genl_family_rcv_msg_attrs_parse.isra.0+0x230/0x230
[ 3711.109025]  ? genl_get_cmd+0x339/0x740
[ 3711.109035]  ? apparmor_capable+0xf0/0x2e0
[ 3711.109047]  ? security_capable+0x7b/0x150
[ 3711.109057]  genl_rcv_msg+0x428/0x6f0
[ 3711.109064]  ? genl_family_rcv_msg_dumpit+0x2c0/0x2c0
[ 3711.109072]  ? nl80211_join_mesh+0x1060/0x1060 [cfg80211]
[ 3711.109152]  ? nl80211_parse_key+0xe80/0xe80 [cfg80211]
[ 3711.109229]  ? nlmsg_trim+0x60/0x60 [cfg80211]
[ 3711.109308]  ? __lock_acquire+0x459/0x2170
[ 3711.109319]  netlink_rcv_skb+0x123/0x380
[ 3711.109328]  ? genl_family_rcv_msg_dumpit+0x2c0/0x2c0
[ 3711.109335]  ? lock_acquire+0x178/0x2f0
[ 3711.109343]  ? netlink_ack+0xd80/0xd80
[ 3711.109353]  ? netlink_deliver_tap+0xcb/0xa70
[ 3711.109360]  ? netlink_deliver_tap+0x14c/0xa70
[ 3711.109368]  genl_rcv+0x24/0x40
[ 3711.109375]  netlink_unicast+0x5bf/0x970
[ 3711.109382]  ? netlink_attachskb+0x940/0x940
[ 3711.109391]  ? __check_object_size+0x3bc/0x630
[ 3711.109403]  netlink_sendmsg+0x754/0xc10
[ 3711.109412]  ? netlink_unicast+0x970/0x970
[ 3711.109420]  ? find_held_lock+0x2b/0x80
[ 3711.109428]  ? netlink_unicast+0x970/0x970
[ 3711.109435]  __sock_sendmsg+0xc1/0x150
[ 3711.109447]  ____sys_sendmsg+0x617/0x900
[ 3711.109453]  ? copy_msghdr_from_user+0x26f/0x430
[ 3711.109460]  ? kernel_sendmsg+0x30/0x30
[ 3711.109465]  ? move_addr_to_kernel+0xf0/0xf0
[ 3711.109472]  ? lock_acquire+0x178/0x2f0
[ 3711.109481]  ? __lock_acquire+0x459/0x2170
[ 3711.109488]  ? lock_acquire+0x178/0x2f0
[ 3711.109494]  ___sys_sendmsg+0xfc/0x180
[ 3711.109501]  ? copy_msghdr_from_user+0x430/0x430
[ 3711.109506]  ? lock_acquire+0x178/0x2f0
[ 3711.109516]  ? _copy_from_user+0x3e/0x90
[ 3711.109533]  __sys_sendmsg+0x120/0x1b0
[ 3711.109541]  ? __sys_sendmsg_sock+0x20/0x20
[ 3711.109551]  ? lock_release+0x17b/0x2a0
[ 3711.109560]  do_syscall_64+0x95/0x830
[ 3711.109571]  ? rcu_is_watching+0x11/0xb0
[ 3711.109580]  ? kfree+0x2d2/0x5c0
[ 3711.109588]  ? do_syscall_64+0x1dc/0x830
[ 3711.109596]  ? do_sock_setsockopt+0x1be/0x3a0
[ 3711.109603]  ? do_sock_setsockopt+0x1be/0x3a0
[ 3711.109610]  ? move_addr_to_user+0x140/0x140
[ 3711.109617]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 3711.109624]  ? lockdep_hardirqs_on+0x78/0x100
[ 3711.109635]  ? __sys_setsockopt+0x141/0x1f0
[ 3711.109644]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 3711.109649]  ? lockdep_hardirqs_on+0x78/0x100
[ 3711.109656]  ? do_syscall_64+0x1dc/0x830
[ 3711.109662]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 3711.109668]  ? lockdep_hardirqs_on+0x78/0x100
[ 3711.109675]  ? do_syscall_64+0x1dc/0x830
[ 3711.109680]  ? lockdep_hardirqs_on+0x78/0x100
[ 3711.109686]  ? do_syscall_64+0x1dc/0x830
[ 3711.109692]  ? do_syscall_64+0x1dc/0x830
[ 3711.109698]  ? lockdep_hardirqs_on+0x78/0x100
[ 3711.109704]  ? do_syscall_64+0x1dc/0x830
[ 3711.109709]  ? irqentry_exit+0xec/0x670
[ 3711.109718]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 3711.109723] RIP: 0033:0x7f76a129a687
[ 3711.109735] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 =
5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b=
> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[ 3711.109742] RSP: 002b:00007ffd261d3450 EFLAGS: 00000202 ORIG_RAX: 000000=
000000002e
[ 3711.109751] RAX: ffffffffffffffda RBX: 00007f76a0ff9880 RCX: 00007f76a12=
9a687
[ 3711.109756] RDX: 0000000000000000 RSI: 00007ffd261d34d0 RDI: 00000000000=
00006
[ 3711.109761] RBP: 000056466bf8abc0 R08: 0000000000000000 R09: 00000000000=
00000
[ 3711.109766] R10: 0000000000000000 R11: 0000000000000202 R12: 000056466be=
d6140
[ 3711.109770] R13: 00007ffd261d34d0 R14: 0000000000000000 R15: 00007ffd261=
d35b4
[ 3711.109779]  </TASK>
[ 3711.109784] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq xt_conn=
track nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat x_=
tables nf_tables br_netfilter bridge stp llc ccm overlay qrtr rfcomm cmac a=
lgif_hash algif_skcipher af_alg bnep binfmt_misc ext4 mbcache jbd2 nls_asci=
i nls_cp437 vfat fat iwlmvm snd_hda_codec_generic snd_hda_codec_hdmi amd_at=
l mac80211 intel_rapl_msr snd_acp3x_pdm_dma intel_rapl_common snd_acp3x_rn =
snd_soc_dmic snd_hda_intel snd_usb_audio snd_soc_core snd_hda_codec snd_usb=
midi_lib libarc4 snd_intel_dspcfg uvcvideo kvm_amd snd_compress snd_hwdep s=
nd_rawmidi btusb videobuf2_vmalloc btrtl videobuf2_memops snd_seq_device sn=
d_pci_acp6x snd_hda_core kvm btintel uvc snd_pci_acp5x iwlwifi btbcm videob=
uf2_v4l2 snd_pcm irqbypass btmtk videodev snd_rn_pci_acp3x bluetooth snd_ti=
mer rapl snd_acp_config ecdh_generic cfg80211 pcspkr snd wmi_bmof ecc video=
buf2_common snd_soc_acpi ee1004 k10temp snd_pci_acp3x sg mc
[ 3711.110032]  rfkill ccp soundcore battery ac button amd_pmc acpi_tad joy=
dev evdev msr parport_pc ppdev lp parport fuse nvme_fabrics efi_pstore conf=
igfs nfnetlink efivarfs autofs4 crc32c_cryptoapi btrfs blake2b libblake2b x=
or raid6_pq dm_crypt hid_microsoft ff_memless hid_cmedia r8153_ecm cdc_ethe=
r usbnet dm_mod r8152 mii libphy mdio_bus sd_mod uas usb_storage scsi_mod u=
sbhid scsi_common amdgpu drm_client_lib i2c_algo_bit drm_ttm_helper ttm drm=
_exec drm_suballoc_helper drm_buddy drm_panel_backlight_quirks gpu_sched am=
dxcp hid_multitouch drm_display_helper ucsi_acpi hid_generic typec_ucsi drm=
_kms_helper xhci_pci roles cec xhci_hcd sp5100_tco i2c_hid_acpi nvme ghash_=
clmulni_intel typec rc_core serio_raw amd_sfh watchdog i2c_hid usbcore nvme=
_core i2c_piix4 crc16 video thunderbolt i2c_smbus hid fan usb_common wmi dr=
m aesni_intel
[ 3711.110300] ---[ end trace 0000000000000000 ]---
[ 3711.312579] usb 1-4: New USB device found, idVendor=3D04f3, idProduct=3D=
0c00, bcdDevice=3D 2.83
[ 3711.312602] usb 1-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[ 3711.312607] usb 1-4: Product: ELAN:ARM-M4
[ 3711.312613] usb 1-4: Manufacturer: ELAN
[ 3711.422307] RIP: 0010:iwl_mvm_get_wd_timeout+0x10a/0x180 [iwlmvm]
[ 3711.422432] Code: df 48 c1 ea 03 80 3c 02 00 75 6d 49 8b 85 30 01 00 00 =
48 0f ba e0 26 73 27 48 b8 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 <0f=
> b6 04 02 84 c0 74 04 3c 03 7e 21 31 c0 83 7d 00 03 44 0f 44 e0
[ 3711.422441] RSP: 0018:ffff888128caeb68 EFLAGS: 00010256
[ 3711.422454] RAX: dffffc0000000000 RBX: ffff88812864c140 RCX: ffffffffc56=
a2bf4
[ 3711.422459] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff8881286=
4c140
[ 3711.422464] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed10250=
c9828
[ 3711.422469] R10: ffff88812864c147 R11: 0000000000000002 R12: 00000000000=
02710
[ 3711.422473] R13: ffff88812864c010 R14: dffffc0000000000 R15: ffff888136f=
fb0e8
[ 3711.422478] FS:  00007f76a0ff9880(0000) GS:ffff8883e7d30000(0000) knlGS:=
0000000000000000
[ 3711.422485] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3711.422490] CR2: 0000357c0c75f000 CR3: 00000001215c2000 CR4: 00000000007=
50ef0
[ 3711.422497] PKRU: 55555554
[ 3711.592217] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 3711.592242] BUG: KASAN: slab-use-after-free in mutex_can_spin_on_owner+0=
x197/0x1b0
[ 3711.592264] Read of size 4 at addr ffff888133300034 by task kworker/3:2/=
425817

[ 3711.592283] CPU: 3 UID: 0 PID: 425817 Comm: kworker/3:2 Tainted: G      =
D             6.19.0-rc6-00339-g62085877ae65 #373 PREEMPT(voluntary)=20
[ 3711.592291] Tainted: [D]=3DDIE
[ 3711.592293] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.17 12/18/2024
[ 3711.592298] Workqueue: events iwl_mvm_tcm_work [iwlmvm]
[ 3711.592348] Call Trace:
[ 3711.592351]  <TASK>
[ 3711.592354]  dump_stack_lvl+0x6a/0x90
[ 3711.592364]  print_report+0x174/0x4f2
[ 3711.592371]  ? __virt_addr_valid+0x208/0x420
[ 3711.592380]  ? mutex_can_spin_on_owner+0x197/0x1b0
[ 3711.592385]  kasan_report+0xdb/0x180
[ 3711.592394]  ? mutex_can_spin_on_owner+0x197/0x1b0
[ 3711.592402]  mutex_can_spin_on_owner+0x197/0x1b0
[ 3711.592407]  __mutex_lock+0x32c/0x2150
[ 3711.592415]  ? psi_avgs_work+0x9c/0x200
[ 3711.592422]  ? iwl_mvm_recalc_tcm+0xa14/0x1990 [iwlmvm]
[ 3711.592445]  ? collect_percpu_times+0x554/0x960
[ 3711.592452]  ? mutex_lock_io_nested+0x1cc0/0x1cc0
[ 3711.592457]  ? collect_percpu_times+0x135/0x960
[ 3711.592466]  ? iwl_mvm_recalc_tcm+0x1ab/0x1990 [iwlmvm]
[ 3711.592490]  ? rcu_is_watching+0x11/0xb0
[ 3711.592498]  ? lock_release+0x211/0x2a0
[ 3711.592506]  ? iwl_mvm_recalc_tcm+0xa14/0x1990 [iwlmvm]
[ 3711.592527]  iwl_mvm_recalc_tcm+0xa14/0x1990 [iwlmvm]
[ 3711.592554]  ? update_load_avg+0x1e6/0x2020
[ 3711.592560]  ? sched_clock+0xc/0x20
[ 3711.592565]  ? sched_clock_cpu+0x68/0x530
[ 3711.592571]  ? iwl_mvm_tcm_load_percentage+0x20/0x20 [iwlmvm]
[ 3711.592593]  ? rcu_is_watching+0x11/0xb0
[ 3711.592598]  ? lock_acquire+0x2aa/0x2f0
[ 3711.592602]  ? rcu_is_watching+0x11/0xb0
[ 3711.592607]  ? _raw_spin_unlock_irq+0x24/0x50
[ 3711.592615]  process_one_work+0x849/0x1420
[ 3711.592624]  ? pwq_dec_nr_in_flight+0xe00/0xe00
[ 3711.592632]  ? assign_work+0x168/0x240
[ 3711.592638]  worker_thread+0x5ef/0xfd0
[ 3711.592646]  ? process_one_work+0x1420/0x1420
[ 3711.592650]  kthread+0x3ad/0x760
[ 3711.592655]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3711.592659]  ? ret_from_fork+0x71/0x800
[ 3711.592663]  ? ret_from_fork+0x71/0x800
[ 3711.592668]  ? _raw_spin_unlock_irq+0x24/0x50
[ 3711.592673]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3711.592678]  ret_from_fork+0x54a/0x800
[ 3711.592682]  ? exit_thread+0x70/0x70
[ 3711.592687]  ? __switch_to+0x36f/0xd60
[ 3711.592693]  ? kthread_is_per_cpu+0xb0/0xb0
[ 3711.592698]  ret_from_fork_asm+0x11/0x20
[ 3711.592708]  </TASK>

[ 3711.592789] Allocated by task 1:
[ 3711.592796]  kasan_save_stack+0x2c/0x50
[ 3711.592804]  kasan_save_track+0x10/0x30
[ 3711.592810]  __kasan_slab_alloc+0x62/0x70
[ 3711.592817]  kmem_cache_alloc_node_noprof+0x249/0x730
[ 3711.592825]  copy_process+0x36f/0x65f0
[ 3711.592832]  kernel_clone+0xca/0x6d0
[ 3711.592839]  __do_sys_clone3+0x168/0x1b0
[ 3711.592846]  do_syscall_64+0x95/0x830
[ 3711.592853]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

[ 3711.592863] Freed by task 0:
[ 3711.592868]  kasan_save_stack+0x2c/0x50
[ 3711.592875]  kasan_save_track+0x10/0x30
[ 3711.592882]  kasan_save_free_info+0x37/0x50
[ 3711.592889]  __kasan_slab_free+0x3b/0x60
[ 3711.592895]  kmem_cache_free+0x187/0x630
[ 3711.592901]  rcu_do_batch+0x37a/0xd90
[ 3711.592908]  rcu_core+0x6e1/0xaa0
[ 3711.592914]  handle_softirqs+0x1e0/0x780
[ 3711.592921]  __irq_exit_rcu+0xff/0x200
[ 3711.592928]  irq_exit_rcu+0xa/0x20
[ 3711.592934]  sysvec_apic_timer_interrupt+0x89/0xb0
[ 3711.592941]  asm_sysvec_apic_timer_interrupt+0x16/0x20

[ 3711.592952] Last potentially related work creation:
[ 3711.592957]  kasan_save_stack+0x2c/0x50
[ 3711.592963]  kasan_record_aux_stack+0x88/0x90
[ 3711.592970]  __call_rcu_common.constprop.0+0xc9/0x1090
[ 3711.592977]  rcu_do_batch+0x37a/0xd90
[ 3711.592983]  rcu_core+0x6e1/0xaa0
[ 3711.592989]  handle_softirqs+0x1e0/0x780
[ 3711.592996]  run_ksoftirqd+0x37/0x60
[ 3711.593002]  smpboot_thread_fn+0x2f7/0x990
[ 3711.593010]  kthread+0x3ad/0x760
[ 3711.593015]  ret_from_fork+0x54a/0x800
[ 3711.593021]  ret_from_fork_asm+0x11/0x20

[ 3711.593031] Second to last potentially related work creation:
[ 3711.593035]  kasan_save_stack+0x2c/0x50
[ 3711.593041]  kasan_record_aux_stack+0x88/0x90
[ 3711.593048]  __call_rcu_common.constprop.0+0xc9/0x1090
[ 3711.593054]  release_task+0xccc/0x1800
[ 3711.593061]  wait_consider_task+0x10e8/0x3680
[ 3711.593067]  __do_wait+0x603/0x740
[ 3711.593074]  do_wait+0x187/0x400
[ 3711.593080]  kernel_waitid+0xdc/0x110
[ 3711.593086]  __do_sys_waitid+0x18c/0x1b0
[ 3711.593093]  do_syscall_64+0x95/0x830
[ 3711.593099]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

[ 3711.593109] The buggy address belongs to the object at ffff888133300000
                which belongs to the cache task_struct of size 9304
[ 3711.593116] The buggy address is located 52 bytes inside of
                freed 9304-byte region [ffff888133300000, ffff888133302458)

[ 3711.593127] The buggy address belongs to the physical page:
[ 3711.593132] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0=
x0 pfn:0x133300
[ 3711.593139] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0=
 pincount:0
[ 3711.593145] memcg:ffff888181817701
[ 3711.593149] flags: 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D=
0x1fffff)
[ 3711.593159] page_type: f5(slab)
[ 3711.593166] raw: 0017ffffc0000040 ffff8881008b6b40 dead000000000100 dead=
000000000122
[ 3711.593173] raw: 0000000000000000 0000000000030003 00000000f5000000 ffff=
888181817701
[ 3711.593179] head: 0017ffffc0000040 ffff8881008b6b40 dead000000000100 dea=
d000000000122
[ 3711.593185] head: 0000000000000000 0000000000030003 00000000f5000000 fff=
f888181817701
[ 3711.593191] head: 0017ffffc0000003 ffffea0004ccc001 00000000ffffffff 000=
00000ffffffff
[ 3711.593196] head: ffffffffffffffff 0000000000000000 00000000ffffffff 000=
0000000000008
[ 3711.593201] page dumped because: kasan: bad access detected

[ 3711.593209] Memory state around the buggy address:
[ 3711.593214]  ffff8881332fff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[ 3711.593219]  ffff8881332fff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[ 3711.593224] >ffff888133300000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 3711.593229]                                      ^
[ 3711.593234]  ffff888133300080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 3711.593239]  ffff888133300100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[ 3711.593243] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

