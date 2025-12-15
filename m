Return-Path: <linux-wireless+bounces-29757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1203CBE112
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 14:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 952303002D46
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 13:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932D9299AA3;
	Mon, 15 Dec 2025 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CByE8lBi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD1299AAB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805432; cv=none; b=FY9XsnoP76qDPKKP0U/3ojXEOjoNqHLgMv4mACbkVIRobkF3fi0MNDI/J4D/ZrdM7/Klvw775cJVuBcClPzTZYveU2nsShnFcst5V3vk/97RVqb+cl5WNb4OOEy6yA3BG/T2hmK73+9aGLHVdE6wvpX0R6JJtEC+GRnxVCS0C+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805432; c=relaxed/simple;
	bh=2xWSJxm9Lljb5o6K9zyfn0xSpuAXutHIxxDj9OJByjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yy6uGN14xRSJQ+ZOdcqDGVTQpSeig8YaU1bjOOGvLTBjmPObOawobBbOUHLIKIRz5616bFs6VWr9/918ooucdxlDfoNAh0aMeCz/1XTTnHdRe463lLsJBX57daHgoHNCYoKsfPLuLZgsb4oCCEiJ1nuKOjQ4dFCl6hZlFfW895A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CByE8lBi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29efd139227so42024505ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 05:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765805428; x=1766410228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJkDNRjVKTCXxlQ763q4Xz31xc3gzoaQKhtZs+uBIc8=;
        b=CByE8lBiAKSBQ3lF865n9wjbS4UG0oN9ib6PTtqZrcjpDlV7I6NI0IVzMO8G/7fpg4
         G/nSODzv28JfwivalnyvQ/4x4vxWRR3eFx4s+E4DH09fqSCSlQqhJKRLRE4kr0kvz3Vt
         RP6yZDAYeXb+y4plMjP3GNejSbGlaU9YOylyr2rHDUBUH2x5N4CHcmsGSIWjC8um6PEB
         9nNMxHcqzx370CBGZm0KklDjWbMDX602ZHXgawD67hhqPKTCQ+z4LRJBbVnQdWNn7Qcg
         PZvK1SPOgC23FCg7s/l1oWyj4Y1DzK23piqsTzQEj6d8iAgAEQu2ofeu/WlSy1pYPmf2
         LESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765805428; x=1766410228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJkDNRjVKTCXxlQ763q4Xz31xc3gzoaQKhtZs+uBIc8=;
        b=SDsxgRtjXugMURod/VcJflvE545MJVdW9fcXCvXH9OiG+5Ds2OLqHx2V7IJZlt+5dY
         eKgAa7HNXDV4Jok8OKz/Qy6xReoF3R4icPZ4Mg1PXktNH0vjhFWxbB78QH2Jn7B6jnGi
         EeuKsho1/qyGGBAAvOkIsO+p/R+zy5/nTP7LIIr58afgi5xN1V7bwXV/aGLrlpxmK7nj
         JmBo6SlxKJhBSDzSa8kJW0SeURGT6ylTRcloOkbs/fu2m5cj24l+GebjN7b1wpP8hBCx
         UrzMB8zhufQc3OQo47/ujmYRKcMyIsEcECPVnv6gdZHrJGndej5NvG1P+HjEbA6dBXRJ
         rG0A==
X-Forwarded-Encrypted: i=1; AJvYcCX7vvocxtSDbjm5hTSmbZiwNYJ0pd59buTifFlEZJ+8LpsfG0nXZ+8DG0rOMvAAV04GkIt5bjBOXa5CQhktWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZvqUvKLy/go49AC++/loePJoz+Rb9zYZaIam5NCQ4ONAXU6uW
	qWnrvuem1gL7aq0PuSDh31rBu4lQTu6xPeAkJjlATS5dMvO9J3CxPZ0lrl1e7ygEJq9RfqkFEGu
	MzB1WUJ/N2UM2xXEXH2h2hk4s+TmBvw==
X-Gm-Gg: AY/fxX5snL3zM/ZNdZBEdWXxmvbDSYLaOA7BGEgQ6BGMcXOZiVNEaD6Pnmdmg/cowd5
	dLm29iz6ao8qM4AbwAcRFXJt6BAoXpydxOmnr7H/rtJU6VzUwLDMtYjQijDLuaMK1nu0oVUeGJT
	3eGImt8csdNkT2rgigL3C1AbG0kCQZOpXDARgNcbOCALW4Qof0RX+Y8PBot8vUcvn/n1PaqXgGm
	QrV+kvGHZQjRC93GV5jd29E5gZSzF1OVqBHeZJQl3g9xutAGrUT4M1131TNXCiadnki
X-Google-Smtp-Source: AGHT+IGNyZImSxeGZeoUYCfp6rJDQ4U6PuDWgb/0x2U9gBN6DqBTJCQG5Ua3aFtSZvHJd5c9J71DJS/Ut0qLUHmXMMs=
X-Received: by 2002:a17:902:f78e:b0:2a0:945d:a18d with SMTP id
 d9443c01a7336-2a0945da439mr72795495ad.44.1765805428169; Mon, 15 Dec 2025
 05:30:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f355c8a-5bf2-4a74-9b35-daa8ae479736@oss.qualcomm.com>
 <CAKEyCaD4=qeQZYYOv4BTrqUJkZa+jnea1b3BL434X1iGMA-_xg@mail.gmail.com>
 <35c554a3-efdd-425c-ac34-858a927bbe15@oss.qualcomm.com> <e7e4058e-6f95-444f-b843-d942496dcf07@dd-wrt.com>
 <4a91f85b-12cd-42b6-854f-6e9574392791@oss.qualcomm.com> <cf3ff4c8-7884-5c07-11ae-29f169be76a2@oss.qualcomm.com>
 <CAKEyCaBUutjzmg_AKJC1MsssieH12qjCsTMErNm1uJPbv-JUGQ@mail.gmail.com>
In-Reply-To: <CAKEyCaBUutjzmg_AKJC1MsssieH12qjCsTMErNm1uJPbv-JUGQ@mail.gmail.com>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Mon, 15 Dec 2025 14:30:16 +0100
X-Gm-Features: AQt7F2q4yMJsOe75dbChB3hSlehqV4by-aOiit0-807T41hls5sGKgShzCFrHuk
Message-ID: <CAKEyCaDr49O703aa7k9qBzV0sUx2q0JhVGB5STqq01iBmgE3gw@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: add support for MU EDCA
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, 
	Sebastian Gottschall <s.gottschall@dd-wrt.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	quic_yuzha@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:34=E2=80=AFAM Pawe=C5=82 Owoc <frut3k7@gmail.com>=
 wrote:
>
> On Mon, Nov 24, 2025 at 5:35=E2=80=AFAM Vasanthakumar Thiagarajan
> <vasanthakumar.thiagarajan@oss.qualcomm.com> wrote:
> >
> >
> >
> > On 11/24/2025 6:39 AM, Yu Zhang(Yuriy) wrote:
> > >
> > >
> > > On 11/22/2025 6:17 PM, Sebastian Gottschall wrote:
> > >> Am 22.11.2025 um 08:55 schrieb Yu Zhang(Yuriy):
> > >>
> > >>>
> > >>>
> > >>> On 11/21/2025 4:41 PM, Pawe=C5=82 Owoc wrote:
> > >>>> On Fri, Nov 21, 2025 at 6:00=E2=80=AFAM Yu Zhang(Yuriy)
> > >>>> <yu.zhang@oss.qualcomm.com> wrote:
> > >>>>>
> > >>>>> hi,
> > >>>>>
> > >>>>>   From your log/calltrace, I didn=E2=80=99t see any errors relate=
d to MU EDCA;
> > >>>>> what I saw were related to SMPS. Did you also add changes related=
 to SMPS?
> > >>>>>
> > >>>>> Yuriy
> > >>>>
> > >>>> Hi Yuriy,
> > >>>>
> > >>>> Thanks for your reply. The ath11k driver is version 6.14.12.
> > >>>> Everything works if I remove the mu_edca setting without any other=
 changes.
> > >>>>
> > >>>> The problem doesn't occur with the newer IPQ8074 firmware, version=
 2.12-01460,
> > >>>> which hasn't been publicly released.
> > >>>
> > >>> So the newer IPQ8074 firmware fixed this issue, great.
> > >>>
> > >>>>
> > >>>> More details: https://github.com/openwrt/openwrt/issues/20702
> > >>>>
> > >>>> Regards,
> > >> the point is what he mentions that these newer firmwares arent avail=
able public. i
> > >> provided openwrt these images for testing
> > >> so he is asking if or when qualcomm does release newer firmwares to =
the public repositories
> > >>
> > >> Sebastian
> > >>
> > >>>
> > >>>
> > >>>
> > >
> > > hi, Jeff and Vasanthakumar
> > >
> > > When will release the newer IPQ8074 firmware 2.12-01460?
> >
> > I guess the issue has to be addressed with the current firmware binarie=
s as well.
> >
> > @Pawel, can you pls share the debug log with debug_mask=3D0x73 (AHB|WMI=
|MAC|BOOT|QMI)?
> >
> > Vasanth
>
> Hi Vasanth,
>
> Debug logs:
> [ 1343.118355] ath11k c000000.wifi: ipq8074 hw2.0
> [ 1343.118392] ath11k c000000.wifi: FW memory mode: 0
> [ 1343.143829] ath11k c000000.wifi: boot failed to load firmware-2.bin: -=
12
> [ 1343.143879] ath11k c000000.wifi: boot using fw api 1
> [ 1343.149872] ath11k c000000.wifi: boot pm policy 0
> [ 1343.154681] remoteproc remoteproc0: powering up cd00000.q6v5_wcss
> [ 1343.159299] remoteproc remoteproc0: Booting fw image
> IPQ8074/q6_fw.mdt, size 668
> [ 1343.511331] remoteproc remoteproc0: remote processor
> cd00000.q6v5_wcss is now up
> [ 1343.511888] ath11k c000000.wifi: qmi wait for cold boot done
> [ 1343.551276] ath11k c000000.wifi: qmi wifi fw qmi service connected
> [ 1343.551331] ath11k c000000.wifi: qmi indication register request
> [ 1343.557604] ath11k c000000.wifi: qmi host cap request
> [ 1343.563670] ath11k c000000.wifi: qmi firmware request memory request
> [ 1343.567508] ath11k c000000.wifi: qmi mem seg type 4 size 4112384
> [ 1343.573893] ath11k c000000.wifi: qmi mem seg type 2 size 262144
> [ 1343.579899] ath11k c000000.wifi: qmi mem seg type 3 size 786432
> [ 1343.585533] ath11k c000000.wifi: qmi fail to get qcom,m3-dump-addr,
> ignore m3 dump mem req
> [ 1343.591454] ath11k c000000.wifi: qmi req mem_seg[0]
> 0x000000004ba00000 4112384 4
> [ 1343.599779] ath11k c000000.wifi: qmi req mem_seg[1]
> 0x000000004b0c0000 262144 2
> [ 1343.607333] ath11k c000000.wifi: qmi respond memory request delayed 0
> [ 1343.615780] ath11k c000000.wifi: qmi firmware memory ready indication
> [ 1343.620954] ath11k c000000.wifi: qmi target cap request
> [ 1343.628515] ath11k c000000.wifi: chip_id 0x0 chip_family 0x0
> board_id 0xff soc_id 0xffffffff
> [ 1343.632404] ath11k c000000.wifi: fw_version 0x290b84a5
> fw_build_timestamp 2024-09-23 11:32 fw_build_id
> WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
> [ 1343.641113] ath11k c000000.wifi: qmi SMBIOS bdf variant name not set.
> [ 1343.654043] ath11k c000000.wifi: boot using board name
> 'bus=3Dahb,qmi-chip-id=3D0,qmi-board-id=3D255,variant=3DLinksys-MX8500'
> [ 1343.660693] ath11k c000000.wifi: boot firmware request
> ath11k/IPQ8074/hw2.0/board-2.bin size 131180
> [ 1343.671059] ath11k c000000.wifi: boot board name
> [ 1343.679987] ath11k c000000.wifi: 00000000: 62 75 73 3d 61 68 62 2c
> 71 6d 69 2d 63 68 69 70  bus=3Dahb,qmi-chip
> [ 1343.684838] ath11k c000000.wifi: 00000010: 2d 69 64 3d 30 2c 71 6d
> 69 2d 62 6f 61 72 64 2d  -id=3D0,qmi-board-
> [ 1343.694668] ath11k c000000.wifi: 00000020: 69 64 3d 32 35 35 2c 76
> 61 72 69 61 6e 74 3d 4c  id=3D255,variant=3DL
> [ 1343.704460] ath11k c000000.wifi: 00000030: 69 6e 6b 73 79 73 2d 4d
> 58 38 35 30 30           inksys-MX8500
> [ 1343.714270] ath11k c000000.wifi: boot found match board data for
> name 'bus=3Dahb,qmi-chip-id=3D0,qmi-board-id=3D255,variant=3DLinksys-MX85=
00'
> [ 1343.723734] ath11k c000000.wifi: boot found board data for
> 'bus=3Dahb,qmi-chip-id=3D0,qmi-board-id=3D255,variant=3DLinksys-MX8500'
> [ 1343.735717] ath11k c000000.wifi: boot using board api 2
> [ 1343.746637] ath11k c000000.wifi: qmi bdf_type 0
> [ 1343.751929] ath11k c000000.wifi: qmi bdf download req fixed addr type =
0
> [ 1343.757563] ath11k c000000.wifi: boot firmware request
> ath11k/IPQ8074/hw2.0/cal-ahb-c000000.wifi.bin size 131072
> [ 1343.763036] ath11k c000000.wifi: qmi bdf download req fixed addr type =
2
> [ 1343.777486] ath11k c000000.wifi: qmi caldata type: 2
> [ 1343.779656] ath11k c000000.wifi: qmi BDF download sequence completed
> [ 1343.784832] ath11k c000000.wifi: qmi m3 info req
> [ 1343.792257] ath11k c000000.wifi: qmi firmware init done
> [ 1343.792265] ath11k c000000.wifi: qmi wlan mode req mode 7
> [ 1343.887037] ath11k c000000.wifi: qmi Coldboot calibration wait started
> [ 1343.889278] ath11k c000000.wifi: qmi cold boot calibration done
> [ 1343.889280] ath11k c000000.wifi: qmi Coldboot calibration done
> [ 1343.898293] ath11k c000000.wifi: qmi firmware ready
> [ 1343.904177] ath11k c000000.wifi: qmi wifi fw del server
> [ 1343.915094] remoteproc remoteproc0: stopped remote processor
> cd00000.q6v5_wcss
> [ 1343.915124] remoteproc remoteproc0: powering up cd00000.q6v5_wcss
> [ 1343.921524] remoteproc remoteproc0: Booting fw image
> IPQ8074/q6_fw.mdt, size 668
> [ 1344.272140] remoteproc remoteproc0: remote processor
> cd00000.q6v5_wcss is now up
> [ 1344.272205] ath11k c000000.wifi: qmi exit wait for cold boot done
> [ 1344.312104] ath11k c000000.wifi: qmi wifi fw qmi service connected
> [ 1344.312161] ath11k c000000.wifi: qmi indication register request
> [ 1344.318398] ath11k c000000.wifi: qmi host cap request
> [ 1344.324449] ath11k c000000.wifi: qmi firmware request memory request
> [ 1344.328314] ath11k c000000.wifi: qmi mem seg type 4 size 4112384
> [ 1344.334722] ath11k c000000.wifi: qmi mem seg type 2 size 262144
> [ 1344.340728] ath11k c000000.wifi: qmi mem seg type 3 size 786432
> [ 1344.346372] ath11k c000000.wifi: qmi fail to get qcom,m3-dump-addr,
> ignore m3 dump mem req
> [ 1344.352270] ath11k c000000.wifi: qmi req mem_seg[0]
> 0x000000004ba00000 4112384 4
> [ 1344.360607] ath11k c000000.wifi: qmi req mem_seg[1]
> 0x000000004b0c0000 262144 2
> [ 1344.368159] ath11k c000000.wifi: qmi respond memory request delayed 0
> [ 1344.376580] ath11k c000000.wifi: qmi firmware memory ready indication
> [ 1344.381782] ath11k c000000.wifi: qmi target cap request
> [ 1344.389347] ath11k c000000.wifi: chip_id 0x0 chip_family 0x0
> board_id 0xff soc_id 0xffffffff
> [ 1344.393234] ath11k c000000.wifi: fw_version 0x290b84a5
> fw_build_timestamp 2024-09-23 11:32 fw_build_id
> WLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
> [ 1344.401944] ath11k c000000.wifi: qmi SMBIOS bdf variant name not set.
> [ 1344.414869] ath11k c000000.wifi: boot using board name
> 'bus=3Dahb,qmi-chip-id=3D0,qmi-board-id=3D255,variant=3DLinksys-MX8500'
> [ 1344.421515] ath11k c000000.wifi: boot firmware request
> ath11k/IPQ8074/hw2.0/board-2.bin size 131180
> [ 1344.431888] ath11k c000000.wifi: boot board name
> [ 1344.440817] ath11k c000000.wifi: 00000000: 62 75 73 3d 61 68 62 2c
> 71 6d 69 2d 63 68 69 70  bus=3Dahb,qmi-chip
> [ 1344.445680] ath11k c000000.wifi: 00000010: 2d 69 64 3d 30 2c 71 6d
> 69 2d 62 6f 61 72 64 2d  -id=3D0,qmi-board-
> [ 1344.455529] ath11k c000000.wifi: 00000020: 69 64 3d 32 35 35 2c 76
> 61 72 69 61 6e 74 3d 4c  id=3D255,variant=3DL
> [ 1344.465332] ath11k c000000.wifi: 00000030: 69 6e 6b 73 79 73 2d 4d
> 58 38 35 30 30           inksys-MX8500
> [ 1344.475129] ath11k c000000.wifi: boot found match board data for
> name 'bus=3Dahb,qmi-chip-id=3D0,qmi-board-id=3D255,variant=3DLinksys-MX85=
00'
> [ 1344.484576] ath11k c000000.wifi: boot found board data for
> 'bus=3Dahb,qmi-chip-id=3D0,qmi-board-id=3D255,variant=3DLinksys-MX8500'
> [ 1344.496557] ath11k c000000.wifi: boot using board api 2
> [ 1344.507469] ath11k c000000.wifi: qmi bdf_type 0
> [ 1344.512766] ath11k c000000.wifi: qmi bdf download req fixed addr type =
0
> [ 1344.518411] ath11k c000000.wifi: boot firmware request
> ath11k/IPQ8074/hw2.0/cal-ahb-c000000.wifi.bin size 131072
> [ 1344.523873] ath11k c000000.wifi: qmi bdf download req fixed addr type =
2
> [ 1344.538314] ath11k c000000.wifi: qmi caldata type: 2
> [ 1344.540477] ath11k c000000.wifi: qmi BDF download sequence completed
> [ 1344.545676] ath11k c000000.wifi: qmi m3 info req
> [ 1344.553075] ath11k c000000.wifi: qmi firmware init done
> [ 1344.553080] ath11k c000000.wifi: qmi firmware start
> [ 1344.561544] ath11k c000000.wifi: qmi wlan cfg req
> [ 1344.567548] ath11k c000000.wifi: qmi wlan mode req mode 0
> [ 1344.586214] ath11k c000000.wifi: boot htc service 'Control' ul pipe
> 0 dl pipe 1 eid 0 ready
> [ 1344.586242] ath11k c000000.wifi: boot htc service 'Control' eid 0
> tx flow control disabled
> [ 1344.596252] ath11k c000000.wifi: boot htc service HTT Data does not
> allocate target credits
> [ 1344.601745] ath11k c000000.wifi: boot htc service 'HTT Data' ul
> pipe 4 dl pipe 1 eid 1 ready
> [ 1344.609966] ath11k c000000.wifi: boot htc service 'HTT Data' eid 1
> tx flow control disabled
> [ 1344.618673] ath11k c000000.wifi: boot htc service 'WMI' ul pipe 3
> dl pipe 2 eid 2 ready
> [ 1344.626707] ath11k c000000.wifi: boot htc service 'WMI' eid 2 tx
> flow control disabled
> [ 1344.634723] ath11k c000000.wifi: boot htc service 'WMI MAC1' ul
> pipe 7 dl pipe 2 eid 3 ready
> [ 1344.642678] ath11k c000000.wifi: boot htc service 'WMI MAC1' eid 3
> tx flow control disabled
> [ 1344.651303] ath11k c000000.wifi: boot htc service 'WMI MAC2' ul
> pipe 9 dl pipe 2 eid 4 ready
> [ 1344.659346] ath11k c000000.wifi: boot htc service 'WMI MAC2' eid 4
> tx flow control disabled
> [ 1344.668112] ath11k c000000.wifi: wmi wmi_ext_service_bitmap
> 0:0x5e45be01, 1:0x2d94d02, 2:0x1ff030c6, 3:0x6c795c10
> [ 1344.676099] ath11k c000000.wifi: wmi wmi_ext2_service__bitmap
> 0:0x30b784, 1:0xa0809228, 2:0x18a4f17, 3:0x0422
> [ 1344.686514] ath11k c000000.wifi: wmi event service available
> [ 1344.696823] ath11k c000000.wifi: wmi event service ready
> [ 1344.702216] ath11k c000000.wifi: wmi preferred_hw_mode:1
> [ 1344.707525] ath11k c000000.wifi: wmi event service ready ext
> [ 1344.712807] ath11k c000000.wifi: wmi event service ready ext2
> [ 1344.718713] ath11k c000000.wifi: wmi cmd wmi init
> [ 1344.907598] ath11k c000000.wifi: wmi unsupported event id 0x4026
> [ 1344.936927] ath11k c000000.wifi: wmi unsupported event id 0x4026
> [ 1344.988324] ath11k c000000.wifi: wmi processing regulatory channel lis=
t
> [ 1344.988361] ath11k c000000.wifi: wmi status_code REG_SET_CC_STATUS_PAS=
S
> [ 1344.993743] ath11k c000000.wifi: wmi cc US dsf 1 BW: min_2ghz 0
> max_2ghz 40 min_5ghz 2 max_5ghz 160
> [ 1345.000345] ath11k c000000.wifi: wmi num_2ghz_reg_rules 1
> num_5ghz_reg_rules 4
> [ 1345.009370] ath11k c000000.wifi: wmi number of reg rules in 2 GHz band=
: 1
> [ 1345.016660] ath11k c000000.wifi: wmi reg rule 1: (2402 - 2472 @ 40)
> (6, 30) (FLAGS 0)
> [ 1345.023521] ath11k c000000.wifi: wmi number of reg rules in 5 GHz band=
: 4
> [ 1345.031331] ath11k c000000.wifi: wmi reg rule 1: (5170 - 5250 @ 80)
> (6, 30) (FLAGS 0)
> [ 1345.038102] ath11k c000000.wifi: wmi reg rule 2: (5250 - 5330 @ 80)
> (6, 24) (FLAGS 8)
> [ 1345.045915] ath11k c000000.wifi: wmi reg rule 3: (5490 - 5730 @
> 160) (6, 24) (FLAGS 8)
> [ 1345.053727] ath11k c000000.wifi: wmi reg rule 4: (5735 - 5895 @
> 160) (6, 30) (FLAGS 0)
> [ 1345.061541] ath11k c000000.wifi: wmi processed regulatory channel list
> [ 1345.069437] ath11k c000000.wifi: wmi event reg handle chan list
> [ 1345.075947] ath11k c000000.wifi: wmi wmi handle chan list power
> type 0 vdev type 0
> [ 1345.082789] ath11k c000000.wifi: wmi processing regulatory channel lis=
t
> [ 1345.089404] ath11k c000000.wifi: wmi status_code REG_SET_CC_STATUS_PAS=
S
> [ 1345.095913] ath11k c000000.wifi: wmi cc US dsf 1 BW: min_2ghz 0
> max_2ghz 40 min_5ghz 2 max_5ghz 160
> [ 1345.102514] ath11k c000000.wifi: wmi num_2ghz_reg_rules 1
> num_5ghz_reg_rules 4
> [ 1345.111539] ath11k c000000.wifi: wmi number of reg rules in 2 GHz band=
: 1
> [ 1345.118829] ath11k c000000.wifi: wmi reg rule 1: (2402 - 2472 @ 40)
> (6, 30) (FLAGS 0)
> [ 1345.125689] ath11k c000000.wifi: wmi number of reg rules in 5 GHz band=
: 4
> [ 1345.133500] ath11k c000000.wifi: wmi reg rule 1: (5170 - 5250 @ 80)
> (6, 30) (FLAGS 0)
> [ 1345.140272] ath11k c000000.wifi: wmi reg rule 2: (5250 - 5330 @ 80)
> (6, 24) (FLAGS 8)
> [ 1345.148085] ath11k c000000.wifi: wmi reg rule 3: (5490 - 5730 @
> 160) (6, 24) (FLAGS 8)
> [ 1345.155898] ath11k c000000.wifi: wmi reg rule 4: (5735 - 5895 @
> 160) (6, 30) (FLAGS 0)
> [ 1345.163710] ath11k c000000.wifi: wmi processed regulatory channel list
> [ 1345.171606] ath11k c000000.wifi: wmi event reg handle chan list
> [ 1345.178116] ath11k c000000.wifi: wmi wmi handle chan list power
> type 0 vdev type 0
> [ 1345.183940] ath11k c000000.wifi: wmi event ready
> [ 1345.191573] ath11k c000000.wifi: wmi unsupported event id 0x4021
> [ 1345.196414] ath11k c000000.wifi: htt event 48 not handled
> [ 1345.233427] ath11k c000000.wifi: wmi cmd set init country
> [ 1345.233751] ath11k c000000.wifi: wmi processing regulatory channel lis=
t
> [ 1345.234080] ath11k c000000.wifi: wmi cmd set init country
> [ 1345.237848] ath11k c000000.wifi: wmi status_code REG_SET_CC_STATUS_PAS=
S
> [ 1345.237853] ath11k c000000.wifi: wmi cc GB dsf 2 BW: min_2ghz 0
> max_2ghz 40 min_5ghz 2 max_5ghz 160
> [ 1345.256241] ath11k c000000.wifi: wmi num_2ghz_reg_rules 1
> num_5ghz_reg_rules 3
> [ 1345.265256] ath11k c000000.wifi: wmi number of reg rules in 2 GHz band=
: 1
> [ 1345.272552] ath11k c000000.wifi: wmi reg rule 1: (2402 - 2482 @ 40)
> (0, 20) (FLAGS 0)
> [ 1345.279415] ath11k c000000.wifi: wmi number of reg rules in 5 GHz band=
: 3
> [ 1345.287221] ath11k c000000.wifi: wmi reg rule 1: (5170 - 5250 @ 80)
> (0, 23) (FLAGS 512)
> [ 1345.293988] ath11k c000000.wifi: wmi reg rule 2: (5250 - 5330 @ 80)
> (0, 23) (FLAGS 520)
> [ 1345.301808] ath11k c000000.wifi: wmi reg rule 3: (5490 - 5710 @
> 160) (0, 30) (FLAGS 8)
> [ 1345.309794] ath11k c000000.wifi: wmi processed regulatory channel list
> [ 1345.317777] ath11k c000000.wifi: wmi event reg handle chan list
> [ 1345.324280] ath11k c000000.wifi: wmi wmi handle chan list power
> type 0 vdev type 0
> [ 1345.332060] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1345.337783] ath11k c000000.wifi: wmi processing regulatory channel lis=
t
> [ 1345.344599] ath11k c000000.wifi: wmi status_code REG_SET_CC_STATUS_PAS=
S
> [ 1345.351266] ath11k c000000.wifi: wmi cc GB dsf 2 BW: min_2ghz 0
> max_2ghz 40 min_5ghz 2 max_5ghz 160
> [ 1345.357824] ath11k c000000.wifi: wmi num_2ghz_reg_rules 1
> num_5ghz_reg_rules 3
> [ 1345.366835] ath11k c000000.wifi: wmi number of reg rules in 2 GHz band=
: 1
> [ 1345.374109] ath11k c000000.wifi: wmi reg rule 1: (2402 - 2482 @ 40)
> (0, 20) (FLAGS 0)
> [ 1345.380997] ath11k c000000.wifi: wmi number of reg rules in 5 GHz band=
: 3
> [ 1345.388797] ath11k c000000.wifi: wmi reg rule 1: (5170 - 5250 @ 80)
> (0, 23) (FLAGS 512)
> [ 1345.395565] ath11k c000000.wifi: wmi reg rule 2: (5250 - 5330 @ 80)
> (0, 23) (FLAGS 520)
> [ 1345.403364] ath11k c000000.wifi: wmi reg rule 3: (5490 - 5710 @
> 160) (0, 30) (FLAGS 8)
> [ 1345.411371] ath11k c000000.wifi: wmi processed regulatory channel list
> [ 1345.419352] ath11k c000000.wifi: wmi event reg handle chan list
> [ 1345.425856] ath11k c000000.wifi: wmi wmi handle chan list power
> type 0 vdev type 0
> [ 1345.431697] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1371.329758] ath11k c000000.wifi: wmi cmd pdev set param 34 pdev id 1 v=
alue 1
> [ 1371.329813] ath11k c000000.wifi: wmi cmd pdev set param 10 pdev id 1 v=
alue 1
> [ 1371.335954] ath11k c000000.wifi: wmi scan prob req oui 14216286
> [ 1371.342952] ath11k c000000.wifi: wmi cmd pdev set param 35 pdev id 1 v=
alue 0
> [ 1371.348618] ath11k c000000.wifi: wmi cmd pdev dfs phyerr offload
> enable pdev id 1
> [ 1371.355948] ath11k c000000.wifi: wmi cmd pdev set param 143 pdev id 1 =
value 1
> [ 1371.363248] ath11k c000000.wifi: wmi cmd pdev set param 1 pdev id 1 va=
lue 240
> [ 1371.370372] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1371.377495] ath11k c000000.wifi: wmi cmd pdev set param 2 pdev id 1 va=
lue 240
> [ 1371.383552] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1371.390603] ath11k c000000.wifi: wmi mac channel [0/19] freq 5180
> maxpower 46 regpower 46 antenna 0 mode 0
> [ 1371.396673] ath11k c000000.wifi: wmi mac channel [1/19] freq 5200
> maxpower 46 regpower 46 antenna 0 mode 0
> [ 1371.406133] ath11k c000000.wifi: wmi mac channel [2/19] freq 5220
> maxpower 46 regpower 46 antenna 0 mode 0
> [ 1371.415768] ath11k c000000.wifi: wmi mac channel [3/19] freq 5240
> maxpower 46 regpower 46 antenna 0 mode 0
> [ 1371.425391] ath11k c000000.wifi: wmi mac channel [4/19] freq 5260
> maxpower 46 regpower 46 antenna 0 mode 0
> [ 1371.435039] ath11k c000000.wifi: wmi mac channel [5/19] freq 5280
> maxpower 46 regpower 46 antenna 0 mode 0
> [ 1371.444674] ath11k c000000.wifi: wmi mac channel [6/19] freq 5300
> maxpower 46 regpower 46 antenna 0 mode 0
> [ 1371.454309] ath11k c000000.wifi: wmi mac channel [7/19] freq 5320
> maxpower 46 regpower 46 antenna 0 mode 0
> [ 1371.463945] ath11k c000000.wifi: wmi mac channel [8/19] freq 5500
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.473579] ath11k c000000.wifi: wmi mac channel [9/19] freq 5520
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.483215] ath11k c000000.wifi: wmi mac channel [10/19] freq 5540
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.492852] ath11k c000000.wifi: wmi mac channel [11/19] freq 5560
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.502488] ath11k c000000.wifi: wmi mac channel [12/19] freq 5580
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.512211] ath11k c000000.wifi: wmi mac channel [13/19] freq 5600
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.521930] ath11k c000000.wifi: wmi mac channel [14/19] freq 5620
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.531654] ath11k c000000.wifi: wmi mac channel [15/19] freq 5640
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.541376] ath11k c000000.wifi: wmi mac channel [16/19] freq 5660
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.551096] ath11k c000000.wifi: wmi mac channel [17/19] freq 5680
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.560821] ath11k c000000.wifi: wmi mac channel [18/19] freq 5700
> maxpower 60 regpower 60 antenna 0 mode 0
> [ 1371.570551] ath11k c000000.wifi: wmi no.of chan =3D 19 len =3D 552
> pdev_id =3D 1 num_sends =3D 0
> [ 1371.580263] ath11k c000000.wifi: wmi chan scan list chan[0] =3D 5180,
> chan_info->info    20000
> [ 1371.588597] ath11k c000000.wifi: wmi chan scan list chan[1] =3D 5200,
> chan_info->info    20000
> [ 1371.597016] ath11k c000000.wifi: wmi chan scan list chan[2] =3D 5220,
> chan_info->info    20000
> [ 1371.605424] ath11k c000000.wifi: wmi chan scan list chan[3] =3D 5240,
> chan_info->info    20000
> [ 1371.613857] ath11k c000000.wifi: wmi chan scan list chan[4] =3D 5260,
> chan_info->info    20480
> [ 1371.622277] ath11k c000000.wifi: wmi chan scan list chan[5] =3D 5280,
> chan_info->info    20480
> [ 1371.630698] ath11k c000000.wifi: wmi chan scan list chan[6] =3D 5300,
> chan_info->info    20480
> [ 1371.639116] ath11k c000000.wifi: wmi chan scan list chan[7] =3D 5320,
> chan_info->info    20480
> [ 1371.647536] ath11k c000000.wifi: wmi chan scan list chan[8] =3D 5500,
> chan_info->info    20480
> [ 1371.655957] ath11k c000000.wifi: wmi chan scan list chan[9] =3D 5520,
> chan_info->info    20480
> [ 1371.664365] ath11k c000000.wifi: wmi chan scan list chan[10] =3D
> 5540, chan_info->info    20480
> [ 1371.672798] ath11k c000000.wifi: wmi chan scan list chan[11] =3D
> 5560, chan_info->info    20480
> [ 1371.681217] ath11k c000000.wifi: wmi chan scan list chan[12] =3D
> 5580, chan_info->info    20480
> [ 1371.689724] ath11k c000000.wifi: wmi chan scan list chan[13] =3D
> 5600, chan_info->info    20480
> [ 1371.698231] ath11k c000000.wifi: wmi chan scan list chan[14] =3D
> 5620, chan_info->info    20480
> [ 1371.706738] ath11k c000000.wifi: wmi chan scan list chan[15] =3D
> 5640, chan_info->info    20480
> [ 1371.715232] ath11k c000000.wifi: wmi chan scan list chan[16] =3D
> 5660, chan_info->info    20480
> [ 1371.723754] ath11k c000000.wifi: wmi chan scan list chan[17] =3D
> 5680, chan_info->info    20480
> [ 1371.732258] ath11k c000000.wifi: wmi chan scan list chan[18] =3D
> 5700, chan_info->info    20480
> [ 1371.740776] ath11k c000000.wifi: wmi cmd scan chan list channels 19
> [ 1371.749337] ath11k c000000.wifi: wmi cmd lro config pdev_id 0x1
> [ 1371.755344] ath11k c000000.wifi: mac add interface id 0 type 2
> subtype 0 map 3ffffffff
> [ 1371.761248] ath11k c000000.wifi: wmi cmd vdev create id 0 type 2
> subtype 0 macaddr xx:xx:xx:xx:xx:bb pdevid 1
> [ 1371.769239] ath11k c000000.wifi: mac vdev xx:xx:xx:xx:xx:bb
> created, vdev_id 0
> [ 1371.779216] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 48 value 1
> [ 1371.786337] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 91 value 1
> [ 1371.793883] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 34 value 4
> [ 1371.801356] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1371.808821] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 1 value 1
> [ 1371.816633] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 2 value 0
> [ 1371.824527] ath11k c000000.wifi: wmi cmd sta powersave mode psmode
> 0 vdev id 0
> [ 1371.832432] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 1 value -1
> [ 1371.839639] ath11k c000000.wifi: mac defer protection mode setup,
> vdev is not ready yet
> [ 1371.847184] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 7 value 1
> [ 1371.854993] ath11k c000000.wifi: mac Set slottime: 1 for VDEV: 0
> [ 1371.862632] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 8 value 1
> [ 1371.868630] ath11k c000000.wifi: mac Set preamble: 1 for VDEV: 0
> [ 1371.876008] ath11k c000000.wifi: wmi wmm set type 0 ac 0 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1371.881988] ath11k c000000.wifi: wmi wmm set type 0 ac 1 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1371.891110] ath11k c000000.wifi: wmi wmm set type 0 ac 2 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1371.900310] ath11k c000000.wifi: wmi wmm set type 0 ac 3 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1371.909514] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1371.919059] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 4 value 0
> [ 1371.924786] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1371.932517] ath11k c000000.wifi: wmi wmm set type 0 ac 0 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1371.940414] ath11k c000000.wifi: wmi wmm set type 0 ac 1 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1371.949703] ath11k c000000.wifi: wmi wmm set type 0 ac 2 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1371.958904] ath11k c000000.wifi: wmi wmm set type 0 ac 3 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1371.968455] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1371.978000] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 4 value 0
> [ 1371.983728] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1371.991461] ath11k c000000.wifi: wmi wmm set type 0 ac 0 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1371.999356] ath11k c000000.wifi: wmi wmm set type 0 ac 1 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1372.008991] ath11k c000000.wifi: wmi wmm set type 0 ac 2 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1372.018192] ath11k c000000.wifi: wmi wmm set type 0 ac 3 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1372.027742] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1372.037289] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 4 value 0
> [ 1372.043017] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1372.050747] ath11k c000000.wifi: wmi wmm set type 0 ac 0 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1372.058644] ath11k c000000.wifi: wmi wmm set type 0 ac 1 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1372.068281] ath11k c000000.wifi: wmi wmm set type 0 ac 2 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1372.077828] ath11k c000000.wifi: wmi wmm set type 0 ac 3 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1372.087380] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1372.096923] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 4 value 0
> [ 1372.102652] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1372.112495] ath11k c000000.wifi: wmi cmd request stats 0x4 vdev id
> 0 pdev id 1
> [ 1372.112652] ath11k c000000.wifi: wmi stats id 0x4 num chain 0
> [ 1372.125471] ath11k c000000.wifi: wmi event update stats
> [ 1372.131299] ath11k c000000.wifi: wmi debug get fw stat pdev id 1
> vdev id 0 stats id 0x4
> [ 1372.136439] ath11k c000000.wifi: mac txpower from firmware 57,
> reported 28 dBm
> [ 1372.144667] ath11k c000000.wifi: wmi cmd request stats 0x4 vdev id
> 0 pdev id 1
> [ 1372.144782] ath11k c000000.wifi: wmi stats id 0x4 num chain 0
> [ 1372.158812] ath11k c000000.wifi: wmi event update stats
> [ 1372.164629] ath11k c000000.wifi: wmi debug get fw stat pdev id 1
> vdev id 0 stats id 0x4
> [ 1372.169667] ath11k c000000.wifi: mac txpower from firmware 57,
> reported 28 dBm
> [ 1372.178147] ath11k c000000.wifi: wmi cmd request stats 0x4 vdev id
> 0 pdev id 1
> [ 1372.178277] ath11k c000000.wifi: wmi stats id 0x4 num chain 0
> [ 1372.192145] ath11k c000000.wifi: wmi event update stats
> [ 1372.197964] ath11k c000000.wifi: wmi debug get fw stat pdev id 1
> vdev id 0 stats id 0x4
> [ 1372.202992] ath11k c000000.wifi: mac txpower from firmware 57,
> reported 28 dBm
> [ 1372.211080] ath11k c000000.wifi: wmi cmd request stats 0x4 vdev id
> 0 pdev id 1
> [ 1372.211208] ath11k c000000.wifi: wmi stats id 0x4 num chain 0
> [ 1372.225478] ath11k c000000.wifi: wmi event update stats
> [ 1372.231296] ath11k c000000.wifi: wmi debug get fw stat pdev id 1
> vdev id 0 stats id 0x4
> [ 1372.236337] ath11k c000000.wifi: mac txpower from firmware 57,
> reported 28 dBm
> [ 1372.245004] ath11k c000000.wifi: wmi cmd request stats 0x4 vdev id
> 0 pdev id 1
> [ 1372.245133] ath11k c000000.wifi: wmi stats id 0x4 num chain 0
> [ 1372.258812] ath11k c000000.wifi: wmi event update stats
> [ 1372.264628] ath11k c000000.wifi: wmi debug get fw stat pdev id 1
> vdev id 0 stats id 0x4
> [ 1372.269673] ath11k c000000.wifi: mac txpower from firmware 57,
> reported 28 dBm
> [ 1372.281635] ath11k c000000.wifi: wmi cmd request stats 0x4 vdev id
> 0 pdev id 1
> [ 1372.281764] ath11k c000000.wifi: wmi stats id 0x4 num chain 0
> [ 1372.292147] ath11k c000000.wifi: wmi event update stats
> [ 1372.297964] ath11k c000000.wifi: wmi debug get fw stat pdev id 1
> vdev id 0 stats id 0x4
> [ 1372.302993] ath11k c000000.wifi: mac txpower from firmware 57,
> reported 28 dBm
> [ 1372.381175] ath11k c000000.wifi: wmi cmd start scan
> [ 1372.381508] ath11k c000000.wifi: wmi event scan started type 1
> reason 7 freq 5180 req_id 1 scan_id 40960 vdev_id 0 state starting (1)
> [ 1372.393659] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1372.397948] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1372.403131] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5180 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1372.444312] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5180 cmd_flags 0 noise_floor -97 rx_clear_count 5354
> cycle_count 50136 mac_clk_mhz 1
> [ 1372.448433] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5180 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1372.460543] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1372.470268] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1372.476240] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5200 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1372.506965] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5200 cmd_flags 0 noise_floor -96 rx_clear_count 3636
> cycle_count 50128 mac_clk_mhz 1
> [ 1372.511086] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5200 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1372.523226] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1372.532905] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1372.538886] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5220 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1372.569672] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5220 cmd_flags 0 noise_floor -97 rx_clear_count 2372
> cycle_count 50135 mac_clk_mhz 1
> [ 1372.573794] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5220 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1372.585866] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1372.595598] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1372.601577] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5240 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1372.632315] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5240 cmd_flags 0 noise_floor -96 rx_clear_count 11755
> cycle_count 50129 mac_clk_mhz 1
> [ 1372.636438] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5240 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1372.648528] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1372.658319] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1372.664309] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5260 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1372.794974] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5260 cmd_flags 0 noise_floor -97 rx_clear_count 4397
> cycle_count 150111 mac_clk_mhz 1
> [ 1372.799092] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5260 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1372.811111] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1372.820984] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1372.826974] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5280 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1372.957543] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5280 cmd_flags 0 noise_floor -97 rx_clear_count 2353
> cycle_count 150120 mac_clk_mhz 1
> [ 1372.961654] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5280 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1372.973673] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1372.983542] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1372.989535] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5300 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1373.120110] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5300 cmd_flags 0 noise_floor -97 rx_clear_count 4341
> cycle_count 150120 mac_clk_mhz 1
> [ 1373.124233] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5300 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1373.136302] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1373.146115] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1373.152106] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5320 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1373.282736] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5320 cmd_flags 0 noise_floor -97 rx_clear_count 2334
> cycle_count 150119 mac_clk_mhz 1
> [ 1373.286849] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5320 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1373.298886] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1373.308737] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1373.314727] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5500 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1373.445363] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5500 cmd_flags 0 noise_floor -97 rx_clear_count 821
> cycle_count 150113 mac_clk_mhz 1
> [ 1373.449479] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5500 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1373.461482] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1373.471281] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1373.477271] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5520 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1373.607918] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5520 cmd_flags 0 noise_floor -97 rx_clear_count 267
> cycle_count 150115 mac_clk_mhz 1
> [ 1373.612041] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5520 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1373.624187] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1373.633847] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1373.639825] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5540 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1373.770611] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5540 cmd_flags 0 noise_floor -96 rx_clear_count 62601
> cycle_count 150112 mac_clk_mhz 1
> [ 1373.774734] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5540 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1373.786877] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1373.796701] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1373.802692] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5560 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1373.933313] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5560 cmd_flags 0 noise_floor -97 rx_clear_count 274
> cycle_count 150116 mac_clk_mhz 1
> [ 1373.937426] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5560 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1373.949463] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1373.959228] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1373.965219] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5580 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1374.095900] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5580 cmd_flags 0 noise_floor -97 rx_clear_count 702
> cycle_count 150114 mac_clk_mhz 1
> [ 1374.100011] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5580 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1374.112152] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1374.121823] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1374.127806] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5600 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1374.258582] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5600 cmd_flags 0 noise_floor -97 rx_clear_count 458
> cycle_count 150118 mac_clk_mhz 1
> [ 1374.262703] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5600 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1374.274733] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1374.284497] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1374.290488] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5620 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1374.421172] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5620 cmd_flags 0 noise_floor -97 rx_clear_count 3858
> cycle_count 150115 mac_clk_mhz 1
> [ 1374.425293] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5620 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1374.437399] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1374.447175] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1374.453167] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5640 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1374.583831] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5640 cmd_flags 0 noise_floor -96 rx_clear_count 1830
> cycle_count 150118 mac_clk_mhz 1
> [ 1374.587944] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5640 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1374.600070] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1374.609848] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1374.615826] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5660 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1374.746542] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5660 cmd_flags 0 noise_floor -96 rx_clear_count 3208
> cycle_count 150115 mac_clk_mhz 1
> [ 1374.750657] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5660 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1374.760648] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1374.773131] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1374.778536] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5680 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1374.911226] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5680 cmd_flags 0 noise_floor -97 rx_clear_count 1446
> cycle_count 150116 mac_clk_mhz 1
> [ 1374.915348] ath11k c000000.wifi: wmi event scan bss channel type 4
> reason 7 freq 5680 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1374.927367] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1374.937228] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1374.943219] ath11k c000000.wifi: wmi event scan foreign channel
> type 8 reason 7 freq 5700 req_id 1 scan_id 40960 vdev_id 0 state
> running (2)
> [ 1375.073818] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 5700 cmd_flags 0 noise_floor -96 rx_clear_count 45010
> cycle_count 150118 mac_clk_mhz 1
> [ 1375.073908] ath11k c000000.wifi: wmi event chan info vdev_id 0
> err_code 0 freq 0 cmd_flags 1 noise_floor 0 rx_clear_count 0
> cycle_count 0 mac_clk_mhz 0
> [ 1375.087599] ath11k c000000.wifi: wmi chan info report completed
> [ 1375.100955] ath11k c000000.wifi: wmi event scan completed type 2
> reason 0 freq 5700 req_id 1 scan_id 40960 vdev_id 0 state running (2)
> [ 1375.232750] ath11k c000000.wifi: mac chanctx add freq 5180 width 5
> ptr 000000006f627186
> [ 1375.232810] ath11k c000000.wifi: mac chanctx change freq 5180 width
> 5 ptr 000000006f627186 changed 10
> [ 1375.239619] ath11k c000000.wifi: mac chanctx assign ptr
> 000000006f627186 vdev_id 0
> [ 1375.248969] ath11k c000000.wifi: mac vdev 0 start center_freq 5180
> phymode 11ax-he160
> [ 1375.256442] ath11k c000000.wifi: wmi cmd vdev start id 0x0 freq
> 0x143c mode 0x14
> [ 1375.812162] ath11k c000000.wifi: wmi unsupported event id 0x402b
> [ 1375.812402] ath11k c000000.wifi: wmi event pdev ctl failsafe check sta=
tus 0
> [ 1375.820594] ath11k c000000.wifi: wmi event start resp event
> [ 1375.823938] ath11k c000000.wifi: wmi vdev start resp for vdev id 0
> [ 1375.823964] ath11k c000000.wifi: mac vdev xx:xx:xx:xx:xx:bb
> started, vdev_id 0
> [ 1375.835754] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 45 value 887
> [ 1375.842949] ath11k c000000.wifi: mac vdev_id 0 txpower 23
> [ 1375.850501] ath11k c000000.wifi: mac txpower to set in hw 23
> [ 1375.856059] ath11k c000000.wifi: wmi cmd pdev set param 4 pdev id 1 va=
lue 46
> [ 1375.861790] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 3 value 100
> [ 1375.868819] ath11k c000000.wifi: mac Beacon interval: 100 set for VDEV=
: 0
> [ 1375.876199] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 25 value 268435459
> [ 1375.883051] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 94 value 268435459
> [ 1375.891234] ath11k c000000.wifi: wmi cmd peer create vdev_id 0
> peer_addr xx:xx:xx:xx:xx:aa
> [ 1375.891672] ath11k c000000.wifi: wmi unsupported event id 0x601a
> [ 1375.899384] ath11k c000000.wifi: mac Added peer: xx:xx:xx:xx:xx:aa
> for VDEV: 0
> [ 1375.913692] ath11k c000000.wifi: wmi cmd peer set param vdev 0 peer
> 0xxx:xx:xx:xx:xx:aa set param 19 value 3
> [ 1375.920742] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 0
> [ 1375.930723] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 1
> [ 1375.940181] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 2
> [ 1375.949645] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 3
> [ 1375.959106] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 4
> [ 1375.968564] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 5
> [ 1375.978026] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 6
> [ 1375.987488] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 7
> [ 1375.996950] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 8
> [ 1376.006413] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 9
> [ 1376.015874] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 10
> [ 1376.025328] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 11
> [ 1376.034797] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 12
> [ 1376.044345] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 13
> [ 1376.053895] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 14
> [ 1376.063443] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 15
> [ 1376.072993] ath11k c000000.wifi: wmi cmd peer reorder queue setup
> addr xx:xx:xx:xx:xx:aa vdev_id 0 tid 16
> [ 1376.082675] phy3-sta0: authenticate with xx:xx:xx:xx:xx:aa (local
> address=3Dxx:xx:xx:xx:xx:bb)
> [ 1376.092083] phy3-sta0: send auth to xx:xx:xx:xx:xx:aa (try 1/3)
> [ 1376.100611] ath11k c000000.wifi: mac tx mgmt frame, buf id 0
> [ 1376.106248] ath11k c000000.wifi: wmi cmd mgmt tx send
> [ 1376.107162] ath11k c000000.wifi: wmi mgmt tx comp pending 0 desc id 0
> [ 1376.112122] ath11k c000000.wifi: mac tx mgmt frame, vdev_id 0
> [ 1378.139030] phy3-sta0: send auth to xx:xx:xx:xx:xx:aa (try 2/3)
> [ 1378.139113] ath11k c000000.wifi: mac tx mgmt frame, buf id 0
> [ 1378.143782] ath11k c000000.wifi: wmi cmd mgmt tx send
> [ 1378.144690] ath11k c000000.wifi: wmi mgmt tx comp pending 0 desc id 0
> [ 1378.149704] ath11k c000000.wifi: mac tx mgmt frame, vdev_id 0
> [ 1378.168532] phy3-sta0: authenticate with xx:xx:xx:xx:xx:aa (local
> address=3Dxx:xx:xx:xx:xx:bb)
> [ 1378.168587] phy3-sta0: send auth to xx:xx:xx:xx:xx:aa (try 1/3)
> [ 1378.176120] ath11k c000000.wifi: mac tx mgmt frame, buf id 0
> [ 1378.181705] ath11k c000000.wifi: wmi cmd mgmt tx send
> [ 1378.182438] ath11k c000000.wifi: wmi mgmt tx comp pending 0 desc id 0
> [ 1378.187613] ath11k c000000.wifi: mac tx mgmt frame, vdev_id 0
> [ 1378.195160] phy3-sta0: authenticated
> [ 1378.205579] phy3-sta0: associate with xx:xx:xx:xx:xx:aa (try 1/3)
> [ 1378.208397] ath11k c000000.wifi: mac tx mgmt frame, buf id 0
> [ 1378.214342] ath11k c000000.wifi: wmi cmd mgmt tx send
> [ 1378.215343] ath11k c000000.wifi: wmi mgmt tx comp pending 0 desc id 0
> [ 1378.220199] ath11k c000000.wifi: mac tx mgmt frame, vdev_id 0
> [ 1378.229011] phy3-sta0: RX AssocResp from xx:xx:xx:xx:xx:aa
> (capab=3D0x1111 status=3D0 aid=3D2)
> [ 1378.237222] ath11k c000000.wifi: wmi wmm set type 0 ac 0 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.245329] ath11k c000000.wifi: wmi wmm set type 0 ac 1 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.254808] ath11k c000000.wifi: wmi wmm set type 0 ac 2 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.264363] ath11k c000000.wifi: wmi wmm set type 0 ac 3 aifs 2
> cwmin 3 cwmax 7 txop 47 acm 0 no_ack 0
> [ 1378.273900] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1378.283096] ath11k c000000.wifi: wmi wmm set type 1 ac 0 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1378.288910] ath11k c000000.wifi: wmi wmm set type 1 ac 1 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1378.298026] ath11k c000000.wifi: wmi wmm set type 1 ac 2 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1378.307226] ath11k c000000.wifi: wmi wmm set type 1 ac 3 aifs 5
> cwmin 5 cwmax 7 txop 255 acm 0 no_ack 0
> [ 1378.316431] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1378.325623] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 4 value 0
> [ 1378.331524] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1378.339256] ath11k c000000.wifi: wmi wmm set type 0 ac 0 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.347158] ath11k c000000.wifi: wmi wmm set type 0 ac 1 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.356791] ath11k c000000.wifi: wmi wmm set type 0 ac 2 aifs 2
> cwmin 7 cwmax 15 txop 94 acm 0 no_ack 0
> [ 1378.366340] ath11k c000000.wifi: wmi wmm set type 0 ac 3 aifs 2
> cwmin 3 cwmax 7 txop 47 acm 0 no_ack 0
> [ 1378.375535] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1378.384903] ath11k c000000.wifi: wmi wmm set type 1 ac 0 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1378.390730] ath11k c000000.wifi: wmi wmm set type 1 ac 1 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1378.399845] ath11k c000000.wifi: wmi wmm set type 1 ac 2 aifs 5
> cwmin 5 cwmax 7 txop 255 acm 0 no_ack 0
> [ 1378.409047] ath11k c000000.wifi: wmi wmm set type 1 ac 3 aifs 5
> cwmin 5 cwmax 7 txop 255 acm 0 no_ack 0
> [ 1378.418250] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1378.427617] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 4 value 0
> [ 1378.433519] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1378.441250] ath11k c000000.wifi: wmi wmm set type 0 ac 0 aifs 3
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.449153] ath11k c000000.wifi: wmi wmm set type 0 ac 1 aifs 2
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.458787] ath11k c000000.wifi: wmi wmm set type 0 ac 2 aifs 2
> cwmin 7 cwmax 15 txop 94 acm 0 no_ack 0
> [ 1378.468338] ath11k c000000.wifi: wmi wmm set type 0 ac 3 aifs 2
> cwmin 3 cwmax 7 txop 47 acm 0 no_ack 0
> [ 1378.477537] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1378.486905] ath11k c000000.wifi: wmi wmm set type 1 ac 0 aifs 8
> cwmin 9 cwmax 10 txop 255 acm 0 no_ack 0
> [ 1378.492722] ath11k c000000.wifi: wmi wmm set type 1 ac 1 aifs 0
> cwmin 0 cwmax 0 txop 0 acm 0 no_ack 0
> [ 1378.502188] ath11k c000000.wifi: wmi wmm set type 1 ac 2 aifs 5
> cwmin 5 cwmax 7 txop 255 acm 0 no_ack 0
> [ 1378.511304] ath11k c000000.wifi: wmi wmm set type 1 ac 3 aifs 5
> cwmin 5 cwmax 7 txop 255 acm 0 no_ack 0
> [ 1378.520508] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1378.529874] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 4 value 0
> [ 1378.535782] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1378.543501] ath11k c000000.wifi: wmi wmm set type 0 ac 0 aifs 3
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.551409] ath11k c000000.wifi: wmi wmm set type 0 ac 1 aifs 7
> cwmin 15 cwmax 1023 txop 0 acm 0 no_ack 0
> [ 1378.561046] ath11k c000000.wifi: wmi wmm set type 0 ac 2 aifs 2
> cwmin 7 cwmax 15 txop 94 acm 0 no_ack 0
> [ 1378.570592] ath11k c000000.wifi: wmi wmm set type 0 ac 3 aifs 2
> cwmin 3 cwmax 7 txop 47 acm 0 no_ack 0
> [ 1378.579794] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1378.589166] ath11k c000000.wifi: wmi wmm set type 1 ac 0 aifs 8
> cwmin 9 cwmax 10 txop 255 acm 0 no_ack 0
> [ 1378.594979] ath11k c000000.wifi: wmi wmm set type 1 ac 1 aifs 15
> cwmin 9 cwmax 10 txop 255 acm 0 no_ack 0
> [ 1378.604447] ath11k c000000.wifi: wmi wmm set type 1 ac 2 aifs 5
> cwmin 5 cwmax 7 txop 255 acm 0 no_ack 0
> [ 1378.613907] ath11k c000000.wifi: wmi wmm set type 1 ac 3 aifs 5
> cwmin 5 cwmax 7 txop 255 acm 0 no_ack 0
> [ 1378.623111] ath11k c000000.wifi: wmi cmd vdev set wmm params
> [ 1378.632479] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 4 value 0
> [ 1378.635814] qcom-q6v5-wcss-pil cd00000.q6v5_wcss: fatal error received=
:
> [ 1378.635814] QC Image Version:
> QC_IMAGE_VERSION_STRING=3DWLAN.HK.2.9.0.1-02146-QCAHKSWPL_SILICONZ-1
> [ 1378.635814] Image Variant : IMAGE_VARIANT_STRING=3D8074.wlanfw.eval_v2=
Q
> [ 1378.635814]
> [ 1378.635814] wal_tx_control.c:823 Assertion 0 failedparam0 :zero,
> param1 :zero, param2 :zero.
> [ 1378.635814] Thread ID      : 0x0000006b  Thread name    : WLAN RT0
> Process ID     : 0
> [ 1378.635814] Register:
> [ 1378.635814] SP : 0x4bfb95e0
> [ 1378.635814] FP : 0x4bfb95e8
> [ 1378.635814] PC : 0x4b107f58
> [ 1378.635814] SSR : 0x00000008
> [ 1378.635814] BADVA : 0x00020000
> [ 1378.635814] LR : 0x4b1076f4
> [ 1378.635814]
> [ 1378.635814] Stack Dump
> [ 1378.635814] from : 0x4bfb95e0
> [ 1378.635814] to   : 0x4bfb9bb8
> [ 1378.635814]
> [ 1378.638389] ath11k c000000.wifi: wmi cmd set powersave param
> vdev_id 0 param 0 value 0
> [ 1378.693929] remoteproc remoteproc0: crash detected in
> cd00000.q6v5_wcss: type fatal error
> [ 1378.716184] ath11k c000000.wifi: wmi cmd vdev set param vdev 0x0
> param 13 value 2
> [ 1378.724158] remoteproc remoteproc0: handling crash #1 in cd00000.q6v5_=
wcss
> [ 1378.732394] ath11k c000000.wifi: mac DTIM period: 2 set for VDEV: 0
> [ 1378.739857] remoteproc remoteproc0: recovering cd00000.q6v5_wcss
> [ 1378.740462] ath11k c000000.wifi: qmi wifi fw del server
> [ 1378.746696] SError Interrupt on CPU3, code 0x00000000bf000002 -- SErro=
r
> [ 1378.746704] CPU: 3 UID: 0 PID: 49 Comm: kworker/u16:2 Tainted: G
> M       O       6.12.58 #0
> [ 1378.746711] Tainted: [M]=3DMACHINE_CHECK, [O]=3DOOT_MODULE
> [ 1378.746713] Hardware name: Linksys MX8500 (DT)
> [ 1378.746716] Workqueue: events_unbound wiphy_delayed_work_pending [cfg8=
0211]
> [ 1378.746763] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [ 1378.746767] pc : __local_bh_enable_ip+0x8/0x94
> [ 1378.746777] lr : ath11k_ce_send+0x1ac/0x344 [ath11k]
> [ 1378.746799] sp : ffffffc081a6b610
> [ 1378.746800] x29: ffffffc081a6b610 x28: 000000000000001f x27: 000000000=
0000003
> [ 1378.746806] x26: ffffffc079e3f1e8 x25: ffffff80033488c0 x24: ffffff801=
47f7500
> [ 1378.746811] x23: ffffff8014812058 x22: ffffff8014810150 x21: ffffff801=
4813798
> [ 1378.746816] x20: ffffff80148137d8 x19: ffffffc079e3f1e8 x18: ffffffc08=
1a6b2ff
> [ 1378.746821] x17: 6176203331206d61 x16: 7261702030783020 x15: 000000000=
0000005
> [ 1378.746826] x14: 0000000000000000 x13: 30203a5645445620 x12: 000000000=
0000001
> [ 1378.746831] x11: 0000000000000004 x10: 0000000000000048 x9 : 000000000=
0000000
> [ 1378.746836] x8 : ffffff80147f754e x7 : 0000000000000000 x6 : 000000000=
0000000
> [ 1378.746841] x5 : ffffffc094a06400 x4 : 0000000000000000 x3 : 000000002=
0000000
> [ 1378.746845] x2 : 0000000000000064 x1 : 0000000000000200 x0 : 000000000=
0000400
> [ 1378.746852] Kernel panic - not syncing: Asynchronous SError Interrupt
> [ 1378.746855] CPU: 3 UID: 0 PID: 49 Comm: kworker/u16:2 Tainted: G
> M       O       6.12.58 #0
> [ 1378.746859] Tainted: [M]=3DMACHINE_CHECK, [O]=3DOOT_MODULE
> [ 1378.746861] Hardware name: Linksys MX8500 (DT)
> [ 1378.746863] Workqueue: events_unbound wiphy_delayed_work_pending [cfg8=
0211]
> [ 1378.746878] Call trace:
> [ 1378.746881]  dump_backtrace.part.0+0xbc/0xc8
> [ 1378.746888]  show_stack+0x18/0x24
> [ 1378.746892]  dump_stack_lvl+0x5c/0x7c
> [ 1378.746898]  dump_stack+0x18/0x24
> [ 1378.746900]  panic+0x12c/0x308
> [ 1378.746904]  add_taint+0x0/0xb4
> [ 1378.746908]  arm64_serror_panic+0x70/0x7c
> [ 1378.746913]  do_serror+0x28/0x68
> [ 1378.746918]  el1h_64_error_handler+0x30/0x54
> [ 1378.746922]  el1h_64_error+0x68/0x6c
> [ 1378.746925]  __local_bh_enable_ip+0x8/0x94
> [ 1378.746930]  ath11k_htc_send+0x1a4/0x4bc [ath11k]
> [ 1378.746942]  ath11k_hal_rx_sw_mon_ring_buf_paddr_get+0x598/0x265c [ath=
11k]
> [ 1378.746953]  ath11k_wmi_cmd_send+0x98/0x284 [ath11k]
> [ 1378.746963]  ath11k_wmi_vdev_set_param_cmd+0x64/0x104 [ath11k]
> [ 1378.746974]  ath11k_mac_11d_scan_stop+0xabc/0x2678 [ath11k]
> [ 1378.746985]  ieee80211_bss_info_change_notify+0xf8/0x1a4 [mac80211]
> [ 1378.747019]  ieee80211_mgd_set_link_qos_params+0xeac/0x224c [mac80211]
> [ 1378.747041]  ieee80211_sta_rx_queued_mgmt+0x88/0xa68 [mac80211]
> [ 1378.747062]  ieee80211_ibss_leave+0xc54/0x1a50 [mac80211]
> [ 1378.747083]  wiphy_delayed_work_pending+0x324/0x450 [cfg80211]
> [ 1378.747097]  process_one_work+0x178/0x304
> [ 1378.747102]  worker_thread+0x278/0x440
> [ 1378.747106]  kthread+0xdc/0xe0
> [ 1378.747114]  ret_from_fork+0x10/0x20
> [ 1378.747118] SMP: stopping secondary CPUs
> [ 1378.765671] Kernel Offset: disabled
> [ 1378.765673] CPU features: 0x00,00000000,00000000,0200400b
> [ 1378.765676] Memory Limit: none
>
> Regards,

Hi Vasanth,

According to the information in this commit, older firmware versions
do not support EDCA parameter:
https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.w=
lan_host_opensource.4.0.r30/patches/ath11k/0209-QSDK-CP-wifi-ath11k-Fix-the=
-WMM-param-type.patch?ref_type=3Dheads

Thanks Sebastian!

