Return-Path: <linux-wireless+bounces-37260-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOklMK2NHWrFbwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37260-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 15:48:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E93A620420
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A99302D086
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694123AC0F3;
	Mon,  1 Jun 2026 13:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGGZ58Pt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3A437B40A
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321172; cv=pass; b=ozZipxzre6hrkyYKIvF2JnsqHw8M1h1tGVZIj3rT2Jx3/sJxgTrdh1BP6LurvOUNrwcROW/AGVSHvCT/tR/aT7uNldh3V0LmhRkKDnEpRxanSWQ2fdV8polrDkYJ0vPbrU2tNg5KZ7uP1IYtVIk6p0ENR3asBzq7T0e5dSn06pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321172; c=relaxed/simple;
	bh=Z8KqfiByx4s8523VEGT0tBmBUV6i2llxDm7BU0NHJSc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IwYCafP+RZNmwToEfetxlFXN4hCyZ8ihar1Dwc0oQlsEB0YWQ4ORtOn9n18olBKq2u1r1rzvGuVEOleUMUp9hD/cnE4cKsrUPZ3G0p23mbFW1d+g1SDotPtTiKv40izsrwisAO1AM48i9yq1ZPqlbrI1j18kVTHa01vCF2M/0aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGGZ58Pt; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c2d792c8so8805455ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 06:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780321170; cv=none;
        d=google.com; s=arc-20240605;
        b=VQxzDpYD6uH9yNfWCgbXmPNJ0wX1WEmYJ7OHD1EJilXiN7jumd1xKQiEqchY9VtjyB
         +2ERfw3rU+Lg25ZMoQuK482QGpZA0X1sBxVmRtgEEK3u/KAvjWpC465gCw8/j3DS2q3t
         rkRmEpovNJwOHIuqNCqDvJ8XVkU7TGbVwH6a43Hem+FhGUQ90MNiBdzlSSeQX+0bIZek
         KpOcvWXCHBRm8rvecj/xtNBbCEP3ZVxLYz9r2+PIYMkWzALJCMT3VSnLCn5Tpm5uSxdb
         N3dZzgBsJcYPyy0idZbJglvAzzkFu7RibOvxi1YGVJNf1Yy0gy3QBgynxJEdl/n/0sL3
         jANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=J5Ek6HojIDblKK3ugPb4nO67QpVJt/vvhZhxH69MlCk=;
        fh=c6mzDBGwe8YqbGZP+J1UAJ3uG9Kq8fZuSYy19RMY6PY=;
        b=B1AMaed0W0RJA4HhhEugYXyH/Pr5e2ktyoXcx02SwjLEA7/McEQ+w0Ef6yyHEXMNsh
         3GBV9hBO26eVjcg5T6ewOfTfyruwcKAy4SiC7AvFXjcdpy50p7vBeNZZbTrhM0N1Ntu8
         h58UeLXZeeIRQ/gxHF4ijAmDTmJ32GtCxH8a7rFjfrsA6Z/PMF2jE004NrZiVFkoulvU
         yCZCF7VsJBiWc+3AcwrPAiY83qd28wjLrxLv+omAua/QY1rtXZsI2Lu4Q5RbfSFzLbcR
         gDCzlGAehmztWRv5ec79I7ISXKv5jn2VwseWxzt/WAjIVsyFSaBJDXtk+WVycVCbfD7k
         pxFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321170; x=1780925970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Ek6HojIDblKK3ugPb4nO67QpVJt/vvhZhxH69MlCk=;
        b=nGGZ58Pt1VqXhPpnzsGE62K8LD2S7LZkwIybg84YTieyHuOkq5cEcjIJEMOTPeNkhl
         wpS3ZUBplBQcKBlegqpipLFmkXpgQNQnnnZUDb7Of5kdWAk7Gj4T38MM0QGdOLDVE49e
         uWfar73YlH1HBaPz9Gn2Tsm8DkyphNNO9T4EjmKYxFgJx4ccEcGQP89oESVj5BFO2qeJ
         cAdgRD7FWwPP7f2uEDU3tLZjWIGh08xGgxEWpTwLFDOcpTBBnJIIV3ya+ogcpau9jpMV
         Yss+/5sNhvDAMfUiGW7pWTCTp4LiceISLQI7RWUefMjbxfOGWutDeqZlh3zuEUJ1Ek/e
         ecLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321170; x=1780925970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5Ek6HojIDblKK3ugPb4nO67QpVJt/vvhZhxH69MlCk=;
        b=AHk9TkMFlW/tix+TZg6GZ34e/VVrj9S+ghxRnmNThaxeKc8LujiJ4qKmpQshijid9b
         kZbFZ9vT47gPVNaIo8sODenONUDuwmENZV2Ggxh7lzFMXqkbCBRSzGF43raSgr+UIDNw
         D0ItGSCRsYdPBEm3ksJvJfmN+v2f5uF3i9R7u9zLxJJWsMPXQiWAssBY41m/fjrz4SFB
         w2JhbqpwZ5SOX+aklIrIs6kXJ0fCI5Lb8ila1xUrwXWLTkIlPbpEkxGUDugjxeaEZhMQ
         R00YhMRfJ3meCGf6K8GP69O1Aj7S2ICTXzMdJpiOxN0FQVfpDitwltEG5QB11VAgLgVJ
         Exbw==
X-Gm-Message-State: AOJu0YzWKVZvjz+s9ThJkWqYW2cIEkCwXq9Qr8G3BcINeIlq/l1nHau6
	VQ7lKA3qawkohfteGiL/ZTosOFEi2rY/wa5SCKsfmQRdMIpX7Y+jP8+AgatbLJWtUj6s4eGnxU1
	TQplNCqqjwZylcF9flkjcaa8eU6wqERM=
X-Gm-Gg: Acq92OENSmVESEex7g9urnhTNDOI6YWbT+x9BPbpLl7QUnEZIdAS7IX7lmCtSX1aFd3
	Pt7+SUhSmQfg9YlNsxsAF4UyWZtBpX3TFepD0x13uGI35B0WdtTjSavX+KxRSc86VhTywrD9Tc0
	aZhGG9p/DU6PsWUDo6oFY6aRlPyyAjOoUIuOMMwDeHLcp/Ul4jmWImtONtH6hhxJ8GORcS3nrnX
	Wn7zgVF3IgRWvR+JqsKlloYiCKGSeiZ1iMz2Smx2m7QZZjrJ0I0k8LDmKvAc4rLvPTzMh1kTI0n
	tdMOEzt0CVcn9n0=
X-Received: by 2002:a17:902:e88c:b0:2bf:30c8:bfa1 with SMTP id
 d9443c01a7336-2bf368bd8aamr126612315ad.41.1780321170299; Mon, 01 Jun 2026
 06:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cam enih <nanericwang@gmail.com>
Date: Mon, 1 Jun 2026 21:39:19 +0800
X-Gm-Features: AVHnY4Li8ZVexkNxgbuDUYcEqkP0CmXl-rZSxz2_LZ6Z0-nSKca9R4wKx1rcyuo
Message-ID: <CAPB3MF5E0hGRLHALazhQQx7DvkOyS+-Oif0vawkjsuN2vTEEYw@mail.gmail.com>
Subject: =?UTF-8?Q?iwlwifi=3A_8086=3A7740_firmware_crash_=E2=80=93_SYSTEM=5FSTATIST?=
	=?UTF-8?Q?ICS=5FCMD_timeout_after_roam?=
To: linuxwifi@intel.com
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-37260-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nanericwang@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E93A620420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I'm seeing a reproducible firmware crash on an Intel Wi=E2=80=91Fi 7 CNVi a=
dapter
(8086:7740) on an Arrow Lake platform. The crash causes a full device
reset, briefly dropping connectivity.

Hardware: Intel Corporation Arrow Lake CNVi WiFi [8086:7740] (rev 04)
Driver: iwlwifi
Firmware version: 101.6e695a70.0 bz-b0-fm-c0-c101.ucode
Kernel:  7.0.10-2-cachyos
Distribution: Arch Linux

The crash occurs when the client roams from one BSSID to another
(c0:8b:05:b2:f3:b2 =E2=86=92 c0:8b:05:b2:f3:c2). The event always happens a=
bout
15=E2=80=9320 minutes after connecting, immediately after a
SYSTEM_STATISTICS_CMD timeout:

[  +0.065429] wlp0s20f3: Limiting TX power to 30 (30 - 0) dBm ...
[Jun 1 21:24] iwlwifi 0000:00:14.3: Error sending
SYSTEM_STATISTICS_CMD: time out after 2000ms.
[  +0.000012] iwlwifi 0000:00:14.3: Current CMD queue read_ptr 5552
write_ptr 5553
[  +0.002087] iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
...
[  +4.582072] iwlwifi 0000:00:14.3: HCMD_ACTIVE already clear for
command SYSTEM_STATISTICS_CMD
...
[  +0.554468] iwlwifi 0000:00:14.3: restart completed

Please let me know if you need any additional debug data or if there is
a firmware update / patch I should test. I'm happy to try experimental
builds.

Thank you,
Eric

