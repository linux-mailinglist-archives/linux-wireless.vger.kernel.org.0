Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610966E9315
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 13:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjDTLkn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjDTLkm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 07:40:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA810198
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 04:40:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o29-20020a05600c511d00b003f1739de43cso956487wms.4
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 04:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681990838; x=1684582838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ifFMBd3GJHi70HvrE1ZkmeruEFQ32wue1ioYSLszInQ=;
        b=QPYYSm4+bk/EanrpEfJr94fJAA9cv+8b6bgmYEBHX3snSgS8UE9SnxPNMey4f/8h3w
         o+zrpDVLey56KY9UKlYbcx/55Oq2K0D8UnTQK0lUzMnEt5njllQKmEhDrUPAyc4i6XeR
         FwmUCKYy+KRHwB/Q9COY5AxnEmQ8H+19qWbTXiP/WcvkeZchRLqXm9FAM9J97Nempuo+
         +/SkwEnSHskiUXalnvNerfbcQPISTwGkWewoziQD4xMf1+ENXz079I3CxJBQcryAMBRs
         d2RfrE4+8g4GeBWwXXGRcOAB4j6+3VMIGdU1a1Jyp3OLcctEXu0vMapbmchlBHuRSzK4
         1DJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681990838; x=1684582838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifFMBd3GJHi70HvrE1ZkmeruEFQ32wue1ioYSLszInQ=;
        b=eby6a4AtAsIwL+tOgdg8X4S9agGoynFu39Wg8CGWF8WdDNwgTQTONpDRsZO7RFYZqT
         9vpBEhbifTERnOyjB3Iw4MrFTS9J9eecbmWWbjBViDTbcPZ043Ez9ZIjLzT3KhhyfnEU
         ZQbZ60fv10+RtcrdRLA+5vh2TRsgm/8ggY67gWihu/1im/eyMRGKaTmTJEiISrQjsnXv
         e4ZVmFoHcF/YsvUkU6YVuv5HV2psBYKlJa8siQt3+jyW2tUldbktnQtEddlQMXz8iRoC
         EniCuiQJ0PJB+fJ0L/ocez0Gk6GqKe//27tBaX+NXgtICzbQozUx87Jb9Qo6ZY1vuqbr
         SntA==
X-Gm-Message-State: AAQBX9ebBiR5EzlhSFBtx2tWO9tYgRZpjgzA/Ds7SsFf60wJleuXnePd
        X71XxOHH+yy5+8LmUhCwuuLNBQqQaXb0kFTQGvBxNwfVLo4=
X-Google-Smtp-Source: AKy350bpEMMuFxR2wjPEVb73p3rxgxYLnsKsDK9Rg7d2B1d9N8a3m2dmkynWReYla6kpJ0s0AT/Q5OEJTAg6Me97SB8=
X-Received: by 2002:a1c:7404:0:b0:3ed:a82d:dffb with SMTP id
 p4-20020a1c7404000000b003eda82ddffbmr1006614wmc.40.1681990838098; Thu, 20 Apr
 2023 04:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
 <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com> <CALbLcfB7cMctHC-Fv93z1WVCZkQ76uW2F_=P6rCW7ZSPXvmapw@mail.gmail.com>
 <2857f998-1b1a-e3c2-20fe-d03dadcf8f23@gmail.com> <CALbLcfCsyGzhvrqjSz37+7cLvc3rc4Y_kgspZV=kiPNs4TBE4w@mail.gmail.com>
 <CALbLcfBnF6njFMSfQk2TuOiZ3C3kHwqs4-c-MQGb72azzQ5sJA@mail.gmail.com>
 <38172c8e-d107-d96e-7292-09d0e3b061dd@gmail.com> <CALbLcfCHLU+zoFdTnTrJs22UUYwr2rETp5hqbv=NL352Qz-XgA@mail.gmail.com>
 <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
In-Reply-To: <CALbLcfDZJmOyn-Gf24+9X-eHh3-3PY4_nP5soG3gHf_Vn85=EA@mail.gmail.com>
From:   Artem Makhutov <artem.makhutov@gmail.com>
Date:   Thu, 20 Apr 2023 13:40:28 +0200
Message-ID: <CALbLcfAiVgGi9iocEG4OfgET2XLDRq0dthbxDMP0vP3R6BBp_A@mail.gmail.com>
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I think that I have found the problem: It happens when rx_desc->rxht
== 1 - then the urb is 4 bytes shorter...

ping -I wlan0 -s 1430 10.10.0.1
PING 10.10.0.1 (10.10.0.1) from 10.10.0.111 wlan0: 1430(1458) bytes of data.
1438 bytes from 10.10.0.1: icmp_seq=3 ttl=64 time=4.15 ms
1438 bytes from 10.10.0.1: icmp_seq=4 ttl=64 time=3.75 ms
1438 bytes from 10.10.0.1: icmp_seq=5 ttl=64 time=10.7 ms
1438 bytes from 10.10.0.1: icmp_seq=6 ttl=64 time=3.51 ms
1438 bytes from 10.10.0.1: icmp_seq=7 ttl=64 time=3.87 ms
1438 bytes from 10.10.0.1: icmp_seq=8 ttl=64 time=15.1 ms
1438 bytes from 10.10.0.1: icmp_seq=9 ttl=64 time=4.07 ms
--- 10.10.0.1 ping statistics ---
60 packets transmitted, 7 received, 88.3333% packet loss, time 61093ms
rtt min/avg/max/mdev = 3.508/6.451/15.148/4.258 ms

[ 1169.872268]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1170.880400]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1171.918891]   pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 4 rxht 0
[ 1172.920275]   pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 4 rxht 0
[ 1173.928173]   pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 4 rxht 0
[ 1174.923142]   pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 4 rxht 0
[ 1175.925513]   pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 4 rxht 0
[ 1176.937914]   pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 4 rxht 0
[ 1177.928766]   pkt_cnt 136 pkt_len 1508 drvinfo_sz 32 desc_shift 0
rxmcs 4 rxht 0
[ 1178.930020]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1180.007753]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1181.038649]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1182.078398]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1183.121640]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1184.160263]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1185.198899]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1186.238398]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1187.278894]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1188.317408]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1189.358896]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1190.397363]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1191.437506]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1192.477508]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1193.525388]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1193.526503]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1194.557519]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1195.597382]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1196.637391]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1197.677132]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1198.717459]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1199.757154]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1200.798631]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1201.837757]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1201.838238]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1202.877144]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1203.917151]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1204.959267]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1205.999003]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1207.041389]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1208.077647]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1209.117016]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1210.157660]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1211.199025]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1212.243013]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1213.288022]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 12 rxht 1
[ 1214.318898]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1215.358262]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1216.407514]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 13 rxht 1
[ 1217.437255]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1218.481128]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1219.517389]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1220.557630]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1221.596888]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1222.647014]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1223.677259]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 16 rxht 1
[ 1224.716758]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 16 rxht 1
[ 1225.760018]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1226.803382]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
[ 1227.837137]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1228.877134]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1229.917130]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 14 rxht 1
[ 1230.957130]   pkt_cnt 136 pkt_len 1504 drvinfo_sz 32 desc_shift 0
rxmcs 15 rxht 1
