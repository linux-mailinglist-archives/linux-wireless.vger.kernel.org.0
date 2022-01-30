Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4876C4A35F8
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jan 2022 12:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354660AbiA3Lfr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jan 2022 06:35:47 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:56631 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354655AbiA3Lfr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jan 2022 06:35:47 -0500
Received: from [192.168.1.107] ([37.4.249.169]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MekrN-1meFyY03lN-00anHH; Sun, 30 Jan 2022 12:35:31 +0100
Subject: Re: [PATCH RFC 1/4] brcmfmac: use separate firmware for 43430
 revision 4
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Phil Elwell <phil@raspberrypi.com>, devicetree@vger.kernel.org,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-rpi-kernel@lists.infradead.org
References: <1641068812-5851-1-git-send-email-stefan.wahren@i2se.com>
 <1641068812-5851-2-git-send-email-stefan.wahren@i2se.com>
 <8ed4450d-85d9-c69b-761a-7695b3f1bbb3@i2se.com>
 <dff5f86f-d6a5-f197-3c90-3b77d06991ce@broadcom.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdudVBHIHYy
 CgptUUlOQkZ0NmdCTUJFQUN1Yi9wQmV2SHhidkplZnlaRzMySklObW4yYnNFUFgyNVY2ZmVq
 bXlZd21DR0tqRnRMCi9Eb1VNRVZIRHhDSjQ3Qk1YbzM0NGZIVjFDM0FudWRnTjFCZWhMb0J0
 TEh4bW5lQ3pnSDNLY1B0V1c3cHRqNEcKdEp2OUNRRFp5MjdTS29FUHh5YUk4Q0YweWdSeEpj
 NzJNOUk5d21zUFo1YlVIc0x1WVdNcVE3SmNSbVBzNkQ4ZwpCa2srOC95bmdFeU5FeHd4SnBS
 MXlsajVianhXREh5WVF2dUo1THpaS3VPOUxCM2xYVnNjNGJxWEVqYzZWRnVaCkZDQ2svc3lp
 by9ZaHNlOE4rUXN4N01RYWd6NHdLVWtRUWJmWGcxVnFrVG5BaXZYczQyVm5Ja211NWd6SXcv
 MHQKUkp2NTBGUmhIaHhweUtBSThCOG5oTjhRdng3TVZrUGM1dkRmZDN1R1lXNDdKUGhWUUJj
 VXdKd05rLzQ5RjllQQp2ZzJtdE1QRm5GT1JrV1VSdlArRzZGSmZtNitDdk92N1lmUDF1ZXdB
 aTRsbitKTzFnK2dqVklXbC9XSnB5MG5UCmlwZGZlSDlkSGtnU2lmUXVuWWN1Y2lzTXlvUmJG
 OTU1dENna0VZOUVNRWRZMXQ4aUdEaUNnWDZzNTBMSGJpM2sKNDUzdWFjcHhmUVhTYUF3UGtz
 bDhNa0NPc3YyZUVyNElOQ0hZUUR5WmljbEJ1dUNnOEVOYlI2QUdWdFpTUGNRYgplbnpTektS
 Wm9POUNhcUlEK2ZhdkxpQi9kaHptSEErOWJnSWhtWGZ2WFJMRFp6ZThwbzFkeXQzRTFzaFhp
 ZGRaClBBOE51SlZ6RUl0MmxtSTZWOHBaRHBuMjIxcmZLaml2UlFpYW9zNTRUZ1pqak1ZSTdu
 bko3ZTZ4endBUkFRQUIKdENCVGRHVm1ZVzRnVjJGb2NtVnVJRHgzWVdoeVpXNXpkRUJuYlhn
 dWJtVjBQb2tDTndRVEFRZ0FJUVVDWElkYwo0Z0liQXdVTENRZ0hBZ1lWQ0FrS0N3SUVGZ0lE
 QVFJZUFRSVhnQUFLQ1JDVWdld1BFWkR5MjFPVEQvOUdpWkxkCnRSWWNteVJKZ2x0aVFRekFp
 UWRjSUQ3OGxHb1dwL3grci92Y1U2YjZqdVl1ZVR3Z1Iwclc3djdsMklSQnlEN24KSEp4YSt0
 SVNvUVpCZ2hvbE1JZmI5TXRoR09KTENZNzdrL1FoQWhuMzJOR1prZWp3OXR6a3MvNDBtclpT
 VVQ4NApaeWJzUVhyTE0vSFI2VElJL0RlUEIwbktEM0ppcHBzMlVIUUQ5cUQySWpFd1NRUGxI
 akNPckVaaDQ1UFo3bTkrClo5M0x6aVRlc1dabFlRdUxpSndzNHJLcHRIVzFkL3dSZWxzaG1t
 NlFxY0wybDRDL2U0MGVEQjlncTRkU1poOVgKUEVZbGxpeU5RaDdhMkxTZHVtRTFyK2NTd0lq
 RS91ZHRSdmRPOWFLb0psT2JVSzVkTmpTUEg3d0tUYndkWGRZRApHUHdEaFhkNThOQXdyK1BY
 QmxQajB0STFMQ3ErTEJ4ZUt6aFdYK0dWcTlEb2pWanlVREV4Rk5Ga1h1b0M3ZzhtClY5VDB0
 ZUJpdVpSbm91WEt3VjJGcHRaT0hIN0JVRVd0a0t0aGgxZXRmT1dwaWdCemtVN2JQc2ZJWVQr
 cnk5dGIKMW9KK3Y0MVBOYXFaRW1QVXBKeHZmek5UN3Ayd01lRDdaajlmMHJ1YlJQdExBSjJR
 R2pyRkhzdVh3QU9xcHl6ZQoxOEVidHNZazBOMHp1SEVoY2orUEJJQmZoMFlJWWQ1MW9mNkdJ
 aU95UjlxMFhYdHBsVUo3VDIvSDF1UXFrWGxwCitnVzRWa2lmc2NJckl1eWZueFpXMTJlSXZq
 NnlicVdMN2FZS0dZbVQ2aUxDUGJIWXlZY2F5bDRFa0ZjckNGN0UKZTBXVC9zY1ZNaE8vNVgv
 SGFOQTVIQngvcjUycGdMY3Y0aTlNeExRbVUzUmxabUZ1SUZkaGFISmxiaUE4YzNSbApabUZ1
 TG5kaGFISmxia0JwTW5ObExtTnZiVDZKQWpnRUV3RUNBQ0lGQWx0NmdCTUNHd01HQ3drSUJ3
 TUNCaFVJCkFna0tDd1FXQWdNQkFoNEJBaGVBQUFvSkVKU0I3QThSa1BMYmpic1AvamdqYVNz
 NUh0bGtBSXZXUytGcm15N2MKaG5jT0F4TFRWL0Q2UkV3SU95R0poRkt3d29pck55UTJnOXZV
 YTNZQ1lDZjFmSjh3RWhhS09COWQwTHBNUm5MNApkRVQ4ZDgyMzhFL3BLK0hxTktpSXNKaHM2
 SnNLOFpnalZRR3JtbWZua0dyWisxdjBIQnV4ZGljZ0duUC9XdHVBClVsOGw2Mi9BTGJheXlq
 KzYxQ2xyc0V0UklhcU82N0xJWXdQaVBEUkkrWGlNek5pR3pIRi8xUTZHUjAyUkg2YTMKRjg5
 ejhhUHhjSGkxWnZDdDJ5a3o2VUVjaHpQMHI1Z3FGSisvTC9VcHU4ME1YaVk0djVlSWFCNTJn
 VlBnaXlNQQpsTDJkRHMxbUladm5yUkxSWTJ0YjNtQVlOa1Y1QjVJRFQzcGtXeTZrS281T0Nn
 SytZZFlPUjhGTloyb04ydDhPCnJLK1ZudGFLN01NU0tIbG1ZL3NPd3RSbEVoMU9CbXJjQ3dH
 d21wLzA1R2tSNDZmL0lzaFJWZUZPUmF3K0dBcXQKUDIrQ0ZhMkNOQS9JSG5aTm95aWtsRHpQ
 UUhVVUdzck5wcERyaFg5Sm1oQm1nMXYyeXdIMU5YdTFpRGZQMUJBdwpLZ29rdDVmNVVhUkY5
 c0FBNTN2V0V2YlVVTjllZXNGR0x6UFdkSkdRNWhwZC9WSDVJUXk5U0JyaC93SWNla3E1Cm4w
 a042cGJUSHhHRTUyU2kvTVZJa05UdURaM2FwbjJqbERaNHBPdHBCWEkydlAzYlBPK05pcUJa
 anNVM3R4TGkKV2R2MkZqeXp6NlhMUndlV1JZVkw1SGE2TER0eG9yMnZ1NlVQMDdwOXh6MXhS
 WmFPRFczb1lsSEZ6WXBhNFc1ZwpMSGIybEVrSXVVZlNjaWNHYmpqQXRDbFRkR1ZtWVc0Z1Yy
 Rm9jbVZ1SUR4emRHVm1ZVzR1ZDJGb2NtVnVRR2x1CkxYUmxZMmd1WTI5dFBva0NOd1FUQVFn
 QUlRVUNYSWRlaHdJYkF3VUxDUWdIQWdZVkNBa0tDd0lFRmdJREFRSWUKQVFJWGdBQUtDUkNV
 Z2V3UEVaRHkyeUhURC85VUY3UWxEa0d4elE3QWFDSTZOOTVpUWY4LzFvU1VhRE51Mlk2SQpL
 K0R6UXBiMVRiVE9yM1ZKd3dZOGEzT1d6NU5MU09MTVdlVnh0K29zTW1sUUlHdWJEM09EWko4
 aXpQbEcvSnJOCnQ1elNkbU41SUE1ZjNlc1dXUVZLdmdoWkFnVERxZHB2K1pIVzJFbXhuQUox
 dUxGWFhlUWQzVVpjQzVyMy9nL3YKU2FNbzl4ZWszSjVtTnVEbTcxbEVXc0FzL0JBY0ZjK3lu
 TGh4d0JXQld3c3Z3UjhiSHRKNURPTVd2YUt1RHNrcApJR0ZVZS9LYjJCK2pyYXZRM1RuNnMv
 SHFKTTBjZXhTSHo1cGUrMHNHdlArdDlKNzIzNEJGUXdlRkV4cmlleThVCkl4T3I0WEFiYWFi
 U3J5WW5VL3pWSDlVMWkyQUlRWk1XSkFldkN2VmdRL1UrTmVSaFh1ZGU5WVVtRE1EbzJzQjIK
 VkFGRUFxaUYyUVVIUEEybThhN0VPM3lmTDRyTWswaUh6TElLdmg2L3JIOFFDWThpM1h4VE5M
 OWlDTHpCV3UvTgpPbkNBYlMremx2TFphaVNNaDVFZnV4VHR2NFBsVmRFamY2MlArWkhJRDE2
 Z1VEd0VtYXpMQU1yeDY2NmpINWt1ClVDVFZ5bWJMMFR2Qis2TDZBUmw4QU55TTRBRG1rV2tw
 eU0yMmtDdUlTWUFFZlFSM3VXWFo5WWd4YVBNcWJWK3cKQnJoSmc0SGFONkM2eFRxR3YzcjRC
 MmFxYjc3L0NWb1JKMVo5Y3BIQ3dpT3pJYUFtdnl6UFU2TXhDRFhaOEZnWQpsVDR2MjNHNWlt
 SlAyemdYNXMrRjZBQ1VKOVVRUEQwdVRmK0o5RGEycitza2gvc1dPbloreWNvSE5CUXZvY1pF
 Ck5BSFFmN2tDRFFSYmVvQVRBUkFBMkhkMGZzRFZLNzJSTFNESGJ5ME9oZ0RjRGxWQk0yTSto
 WVlwTzNmWDFyKysKc2hpcVBLQ0hWQXNRNWJ4ZTdIbUppbUhhNEtLWXMya3YvbWx0L0NhdUNK
 Ly9wbWN5Y0JNN0d2d25Lem11WHp1QQpHbVZUWkM2V1I1TGtha0ZydEhPelZtc0VHcE52NVJj
 OWw2SFlGcExrYlNrVmk1U1BRWkp5K0VNZ01DRmdqclpmClZGNnlvdHdFMWFmN0hOdE1oTlBh
 TEROMW9VS0Y1aitSeVJnNWl3SnVDRGtuSGp3QlFWNHBndzIvNXZTOEE3WlEKdjJNYlcvVExF
 eXBLWGlmNzhJaGdBelh0RTJYck0xbi9vNlpINzFvUkZGS096NDJsRmR6ZHJTWDBZc3FYZ0hD
 WAo1Z0l0TGZxemoxcHNNYTlvMWVpTlRFbTFkVlFyVHFueXMwbDE4b2FsUk5zd1lsUW1uWUJ3
 cHdDa2FUSExNSHdLCmZHQmJvNWRMUEVzaHRWb3dJNm5zZ3FMVHlRSG1xSFlxVVpZSXBpZ21t
 QzNTd0JXWTFWNmZmVUVta3FwQUFDRW4KTDQvZ1Vnbjd5US81ZDBzZXFuQXEycFNCSE1VVW9D
 Y1R6RVFVV1ZraUR2M1JrN2hURm1oVHNNcTc4eHYyWFJzWApNUjZ5UWhTVFBGWkNZRFVFeEVs
 RXNTbzlGV0hXcjZ6SHlZY2M4cURMRnZHOUZQaG1RdVQyczlCbHg2Z0kzMjNHCm5FcTFsd1dQ
 SlZ6UDRqUWtKS0lBWHdGcHYrVzhDV0xxekRXT3ZkbHJEYVRhVk1zY0ZUZUg1VzZVcHJsNjVq
 cUYKUUdNcGNSR0NzOEdDVVcxM0gwSXlPdFF0d1dYQTRueStTTDgxcHZpQW1hU1hVOGxhS2FS
 dTkxVk9WYUY5ZjRzQQpFUUVBQVlrQ0h3UVlBUUlBQ1FVQ1czcUFFd0liREFBS0NSQ1VnZXdQ
 RVpEeTIrb1hELzljSEhSa0JaT2ZrbVNxCjE0U3Z4MDYyUHRVMEtWNDcwVFNucC9qV29ZSm5L
 SXczRzBtWElSZ3J0SDJkUHdwSWdWanNZeVJTVk1LbVNwdDUKWnJEZjlOdFRiTldnazhWb0xl
 WnpZRW8rSjNvUHFGclRNczNhWVl2N2U0K0pLNjk1WW5tUSttT0Q5bmlhOTE1dApyNUFaajk1
 VWZTVGx5VW15aWMxZDhvdnNmMWZQN1hDVVZSRmNSamZOZkRGMW9ML3BEZ01QNUdaMk93YVRl
 am15CkN1SGpNOElSMUNpYXZCcFlEbUJuVFlrN1B0aHk2YXRXdllsMGZ5L0NxYWpUS3N4Nytw
 OXh6aXU4WmZWWCtpS0IKQ2MrSGUrRURFZEdJRGh2TlovSVFIZk9CMlBVWFdHUytzOUZOVHhy
 L0E2bkxHWG5BOVk2dzkzaVBkWUl3eFM3SwpYTG9LSmVlMTBEamx6c1lzUmZsRk9XMFpPaVNp
 aElDWGlRVjF1cU02dHpGRzlndFJjaXVzNVVBdGhXYU8xT3dVClNDUW1mQ09tNGZ2TUlKSUE5
 cnh0b1M2T3FSUWNpRjNjcm1vMHJKQ3ROMmF3WmZnaThYRWlmN2Q2aGp2MEVLTTkKWFpvaUFa
 WVpEKy9pTG01VGFLV042b0dJdGkwVmpKdjhaWk9aT2ZDYjZ2cUZJa0pXK2FPdTRvclRMRk16
 MjhhbwpVM1F5V3BOQzhGRm1kWXNWdWE4czZnTjFOSWE2eTNxYS9aQjhiQS9pa3k1OUFFejRp
 RElScmdVek1FZzhBazdUCmZtMUtpWWVpVHRCRENvMjVCdlhqYnFzeXhrUUQxbmtSbTZGQVZ6
 RXVPUEllOEp1cVcyeEQ5aXhHWXZqVTVoa1IKZ0pwM2dQNWIrY25HM0xQcXF1UTJFNmdvS1VN
 TEFia0NEUVJiZmw5REFSQUFzRExjYStMbFAydm5mdEVHaHBjQQpCR1ZOUUVGbkdQckNhdVU2
 SGhOODA1V3RQVHRtc1JPdUp6cWdVVDBtcHFXSWZacTZzTXd5dkhLOVRzL0tIM0paClVWYlJD
 M3oyaDNLZmhIL0RhZjk1cGQ2bVBjL2g5dkYvT3kzK2VUV2hnR25QNmNBNWtsUitmTzFXaEc4
 VnJpWHYKck5lUkcyMHN6emplSG9jblNJY1Q1WHVaUjB1REhPaUd4T2l6MXNNUkZUR3h6R095
 MTlSOXJ2dTYzdGlJM2Q3dgpnYzc1T0NBZGtlQi9TZUNFbGFSdzBUZjdMWmJQampzRjI2M0JZ
 bk1mNGtrTkVLdnFXY1UyaWNNcCtxZXpqeW5CCnB2ZXVlMHJDVFFCWUFRbG9GQ1ZUR0hyV1dB
 NkQ0VzVPMkFmSWRJYzF1MUpDWnAyZjVMV1ZvVUZUVklyUW5RUVUKU0hDaWZyOU1aeExUdFBK
 ZFU1Mm9TUHczZGs0aExQOGlKSUx1dnYvYXZhakNzUVlIRXR3WXNiZUZaeGl1TGdscApBN1lj
 Sk5ObXBnQ3BNRDR3VWh2bEN0QUtOQlFXeXIyOTc2OThFUVRuNDZlQmVVNkttMkNpaFhrZ3dD
 eWY4ZXlLCkxFM3NYZXdhcTVrZ1pXdk5xNml1NXFZSVJCOXl3K2NYYzYwZE9aRE9scTkzWDVT
 QVJZemFvZXBrSHo0cmtMa1AKUG8rdENIeUhRUHNHblBYYzlXVDgwREM5Tm5KR2R2VWx5NXJk
 TUk0eHBaeWdlb2tqd293VlFsUFV1Y1M2TXluNwpmOHc4Y2dmQjdDMklBSWNEeDJwUC9IendY
 dmtDT1FOQTdtVjFsTTA4bitnVmtUcnpweGlwNURicTRDSW9ZeDJNCkpaVDhiR1JINlhqY1VE
 S2EwOVFoeVpzQUVRRUFBWWtFUkFRWUFRZ0FEd1VDVzM1ZlF3SWJBZ1VKQThKbkFBSXAKQ1JD
 VWdld1BFWkR5MjhGZElBUVpBUWdBQmdVQ1czNWZRd0FLQ1JCVnhETFBjVk1NamNkc0QvMFJo
 QXN1UVlPeQpyMTNCbDNOaFhrWUFaR3AyWkZER3VrZTdPU2tWOG9qT09UZFR5ei9jT1JHQ2J5
 ZEQrRGd2cUZ5VmRuT1hLZ08wCmxKbUd3ckdlTGRnZ0F2aDBpaHJwNU8wWVVKOWJCU1htR01t
 UVRZSC9BbUxUR2FkYnVqQ1dqNWZGVWtDeXd4aW0KSHV5MFBiMjRwelR2UzUwR1k1WStxSDBG
 SE5haWdka2tpV04zcnVnN0haRXUvQ3lsUFpqT1h6K0QxUVBNckV4dwo3ZC9NS2FiVis5YU5i
 UVlabGRJajk4UXd2VUYxS1N6YThqbFVJdnBoUnEyN0FUOGZER1lHUGZERU1nMmNCT2FlCkty
 N29uUXM0YjdhV082aWZEbHhRVHB6c3pvK0FuODA3Tk1TdFZFRmYrczNBaFZEM2U3bmY4SkJh
 dmJWckFlMGsKb20yNm96elBubnh6K2xxVlZ0dzZVazRYTUl6dGl4L0h3SFl3dUNuY1VYWndL
 MEkzeUFKd2pZd29vck9DaEozUwpFVWJKUVB0R3NneFJERXhWQkZlNk5MUC82MnhQOU82dGFj
 d09kYjBNbVAxYjM5cFJBVEM3YmdkMWxkVUxpNzVaCmxKckowL1NpVkVyb3FOWXk3OXRmbWdB
 WjJVeFptczlTckV5Nm85UVNmc24xYVh2K01QTDlKYUNHbWtQNnpiTFEKTm5kajBKY2FRbmtD
 MHZneWRPMUJtNk11OTZQOXVmbEtaY0FTNndtTE01SWRIT3lqTDg4d0h3anVjakFPQnRjdwpw
 MG9HVG5WT25Sc05ZU084VzhZWi9LZGJ1Nzg1ZGF6TXFKMmlOakFEdUJiZG02TjRqNUVkTW5r
 TG4wQklmUEpwCmRnbTR2bDJVcExqd1JHci9NM3dtbTVwdnMrNnVCN2hrL0ZKaUQvNGxsRU5Q
 NGVNMWg3U200aitWcTZOMSt6VEIKSVhKQWViSXFhc0RwNXlaUzdYcnk0STM2bjg1WEVZZkcw
 MWx0QXlob05WMkRPOFNJUlFwdWkydHErOVJQM1JLMQpKREJ4eEVKWTJFTzVKWjhNeGFQSFEw
 RFQwNWxSRmpLMkFsaGRFSXRqTGpwSjNmVW05c3FMeE1XeHpQNlV6M2lpCjJ1YTR1bnJ0Nk9D
 VHFRd2lqRi8zYlRXaXd2VkFBSG5NRlVpb1hzaEhhb2hWRGNWZm5lSU1mVjBiUUNYWWkzTnAK
 WTB2MFp3Y2lGSCtnU0M3cUQ2WE51aHBWR1NMNElpbGlGeS9TemNhSkV6QUhlTERTaFpQMkNX
 ZG5DNHZnbDM3dApocHg4aDU1WWhKbjZIU3VVelBnaGFLdFZCMmsrajdaZXlaK1NGeHA3SXVi
 SEN3TEhsUWhUNzVSd1EzaUF4S242CjBxajUxY1lUbnF4ZFpYVzZmSDNQa3VNellVNUdwcVIv
 MU9sNWMvd2ZJNmc2QW04eUtXLzBFVUx0K0tuNExGc1MKbTdZM201SDV2MTJVNkpCWXZWK3Ix
 M2paaW9zNEVFREU5M0Q1c05IMk1JeVJ6Q0RxMXpkZHQ0WHV5S0ZqUEtXMQo5aWJaRGZGVjdL
 dUNzdnVMMjNzQmMxc0NNb3ArRTFtVC9ReE9JQTZvRFQxTVFzdHdPVnVReURDdi9PdktTZ2Z6
 CjhGWEdMNkFQY2xqQ3FqOEFKaHhReXN4ZG9pUVA4bS92dStialdHR3Z4dzVzMWxncGlSRFRS
 VVBnY0pKTmFHWTIKVklEclpRaTROU2lOUTBOSWkrZGp1NGZOTW1DcFFxZzh0YkMzY0FhNnl3
 bTZvUUIxU0JobURYMmUxMWdSbGx1SQpPblRHUEUwSFRvM2w3MmxoYmc9PQo9cVpNVgotLS0t
 LUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
Message-ID: <aa3c8cfc-39bf-22e4-cb98-c19c14e7d8bc@i2se.com>
Date:   Sun, 30 Jan 2022 12:35:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dff5f86f-d6a5-f197-3c90-3b77d06991ce@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:6+Z44BygcltFYCjB9aiddCwuTCobdUbQkkkMNJgGOHffd/eHLsf
 zICfXsEkYlqiC7/lAQTwAk8NiJmgfafe+C6PgrI9fi/fVezqdWUyyV5GNJWzbX2fTuU84TF
 VtG6AKGAMeHrpDN4QhzHpN8ABII99BJ/VAFcszPVG9sKLPnvVzXMARYkLNiPBaz9g4e8Jky
 9XH60a5qx0upm3sVLdDpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IPbZ+/MEq8g=:EXvWm1UVFXFtrYmEawM58s
 jjjcybwrQlcNGVUwsuOwi28RlCtxEsTymXcQkLqjejvZaT/vwZb5vM9RhbEGBJZXFPjaFOBSA
 pSSHwgHduTNYIoI4KWPuU0qkzhXWdxlTSMs1TIJm/aObUreUo4m7AadKZBiUTDbRzGIIP6KDC
 yOSceQTBPruJfpJbhCwlRZk0G+sPKNhc5W+unHNjxq2luDj5DRdMJLxCRBzxQSlg95Ge52RJO
 DNvueSr6a7GDWnP1iWN5juCdgJHKao1D1ugv5SjkD9HqhPWXLcyUQhOezQGEZ5iODbZ337mLx
 NxtJyDvyaSELW9A7NfIl2dWZSzm+sdXgo3Nz1RMbabGLkE9P0s9L67gGX+EQAstVkKgkwvGAE
 iAcFVJbvqO3NwQWAlGeY8RqWzXTnbF80QlNgazLr+ju+dusbqG+SDaxhd6TzrKanRFbSJUwo5
 NeZ6Xf0004bPHxCcKWKDXAE6RgbF1qLEmd2kD9U95zFaRvZmnDl7Pdtt6y6M1IXnAdskcAQ+o
 JlLcBCgBIDlBCGMpgW6UKz5ipiOSABQNKn4DZhOHyJyY7HRlg0MQca5S13Mt3bnYHtQb7cCy2
 9vnBUI24xnXtv2T3izcRGUyyVRIml2qezFjdp+heZFjG+q3W7JIG5XweIcn/4owWgeR0XW+Db
 ++NwLseCQ5YxxNcPzGknGvMkTso6SmRV9NsvoS9y0bR7jzDFLPfaq7OvuSq6MztCSTK1Y0MHe
 lY1bPlaLOnmWE92K
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

Am 24.01.22 um 10:43 schrieb Arend van Spriel:
> On 1/22/2022 1:35 PM, Stefan Wahren wrote:
>> Am 01.01.22 um 21:26 schrieb Stefan Wahren:
>>> A separate firmware is needed, for Broadcom 43430 revision 4. This
>>> chip can be found on e.g. certain revisions of Raspberry Pi Zero 2 W.
>>> Original firmware file from IC vendor is named
>>> 'brcmfmac43436-sdio.bin',
>>> but brcmfmac and also btbcm drivers report chip id 43430, so requested
>>> firmware file name is 'brcmfmac43430c0-sdio.bin' in line with other
>>> 43430 revisions.
>>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>>>
>>> Hi,
>>> i'm not sure about all these mappings. All i can say is that the wifi
>>> interface of the RPi Zero 2 cames up with this patch.
>> gentle ping (yes, i'm aware of the merge window)
>
> Sorry, Stefan
>
> Should have seen this earlier, but here it is....
>
>>>
>>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> index 8effeb7..c79bd47 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>>> @@ -618,6 +618,7 @@ BRCMF_FW_DEF(43430A0, "brcmfmac43430a0-sdio");
>>>   /* Note the names are not postfixed with a1 for backward
>>> compatibility */
>>>   BRCMF_FW_CLM_DEF(43430A1, "brcmfmac43430-sdio");
>>>   BRCMF_FW_DEF(43430B0, "brcmfmac43430b0-sdio");
>>> +BRCMF_FW_CLM_DEF(43430C0, "brcmfmac43430c0-sdio");
>>>   BRCMF_FW_CLM_DEF(43455, "brcmfmac43455-sdio");
>>>   BRCMF_FW_DEF(43456, "brcmfmac43456-sdio");
>>>   BRCMF_FW_CLM_DEF(4354, "brcmfmac4354-sdio");
>>> @@ -649,7 +650,8 @@ static const struct brcmf_firmware_mapping
>>> brcmf_sdio_fwnames[] = {
>>>       BRCMF_FW_ENTRY(BRCM_CC_4339_CHIP_ID, 0xFFFFFFFF, 4339),
>>>       BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0x00000001, 43430A0),
>>>       BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0x00000002, 43430A1),
>>> -    BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0xFFFFFFFC, 43430B0),
>>> +    BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0x00000004, 43430C0),
>
> According to the revision mask your firmware seems to be for numerical
> revision 2 of this chip...
>
>>> +    BRCMF_FW_ENTRY(BRCM_CC_43430_CHIP_ID, 0xFFFFFFF8, 43430B0),
>
> and for the b0 the chip revision is 3 (or higher). So the alphanumeric
> revision of your chip would be 'a2' instead of 'c0'.

i changed this to a2 for the next version of this series. But before i
send them out, please doublecheck the kernel log 5.17-rc1 of my RPi Zero
2 W. I confuses me that the bluetooth part tells about BCM43430B0:

[    9.653199] Bluetooth: hci0: BCM: chip id 115
[    9.653749] Bluetooth: hci0: BCM: features 0x0e
[    9.655466] Bluetooth: hci0: BCM43430B0
[    9.655502] Bluetooth: hci0: BCM43430B0 (002.001.012) build 0000
[    9.659512] vc4-drm soc:gpu: bound 3f400000.hvs (ops
vc4_drm_unregister [vc4])
[    9.667047] Bluetooth: hci0: BCM43430B0 'brcm/BCM43430B0.hcd' Patch
[    9.668052] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43430a2-sdio for chip BCM43430/2
[    9.668567] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43430a2-sdio.raspberrypi,model-zero-2-w.bin failed with
error -2
[    9.673724] vc4-drm soc:gpu: bound 3f400000.hvs (ops
vc4_drm_unregister [vc4])
[    9.697996] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43430a2-sdio.raspberrypi,model-zero-2-w.txt failed with
error -2
[    9.816030] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43430a2-sdio for chip BCM43430/2
[    9.840128] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/2
wl0: Oct  9 2020 14:44:32 version 9.88.4.65 (test) (f149b32@shgit) 
(r679549) FWID 01-f40f3270
[    9.919182] random: crng init done
[    9.919200] random: 7 urandom warning(s) missed due to ratelimiting
[   10.105524] vc4-drm soc:gpu: bound 3f400000.hvs (ops
vc4_drm_unregister [vc4])
[   10.118011] vc4-drm soc:gpu: bound 3f902000.hdmi (ops
vc4_drm_unregister [vc4])
[   10.118190] vc4-drm soc:gpu: bound 3f806000.vec (ops
vc4_drm_unregister [vc4])
[   10.118364] vc4-drm soc:gpu: bound 3f004000.txp (ops
vc4_drm_unregister [vc4])
[   10.118503] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops
vc4_drm_unregister [vc4])
[   10.118625] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops
vc4_drm_unregister [vc4])
[   10.118747] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops
vc4_drm_unregister [vc4])
[   10.118847] vc4-drm soc:gpu: bound 3fc00000.v3d (ops
vc4_drm_unregister [vc4])
[   10.119331] checking generic (1e330000 8ca000) vs hw (0 ffffffff)
[   10.119339] fb0: switching to vc4 from simple
[   10.122443] Console: switching to colour dummy device 80x30
[   10.125147] [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor 0
[   10.203822] Console: switching to colour frame buffer device 240x75
[   10.241067] vc4-drm soc:gpu: [drm] fb0: vc4drmfb frame buffer device
[   10.414793] Bluetooth: hci0: BCM4343B0 37.4MHz wlbga_iLNA_iTR
[Baseline: 0092]
[   10.414822] Bluetooth: hci0: BCM43430B0 (002.001.012) build 0092

Thanks


