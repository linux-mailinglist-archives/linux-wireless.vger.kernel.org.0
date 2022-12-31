Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C593565A3B4
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Dec 2022 12:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiLaLLy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Dec 2022 06:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiLaLLx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Dec 2022 06:11:53 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1063F9
        for <linux-wireless@vger.kernel.org>; Sat, 31 Dec 2022 03:11:51 -0800 (PST)
Received: from [192.168.1.139] ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOiU5-1pSwyL11l1-00Q9bA; Sat, 31 Dec 2022 12:11:38 +0100
Message-ID: <d88f4aff-45ad-db10-ada3-f7f5b34a6620@i2se.com>
Date:   Sat, 31 Dec 2022 12:11:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
In-Reply-To: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
To:     Peter Robinson <pbrobinson@gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Justin Forbes <jforbes@fedoraproject.org>,
        regressions@lists.linux.dev, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        "Ivan T. Ivanov" <iivanov@suse.de>
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7Ues6t1etCmr5j4yisEOHoGD6Zi8Qh4rKHglnzBCHRs51ETj0r3
 MvITO0uT+j1spVYgHcegCg8RTaama8VhsRI3twkkkEZ6DN0Hy/oUVoH76TtHUDq12YwlKF2
 f8W4BTBEocjAKoEu2xuUAA5lIlvqR83GatvmgFBFB7frd/rYC602ORfXKmqvfOUBRtpbWsw
 UNtTw3KBwrYoGKsOGzMpg==
UI-OutboundReport: notjunk:1;M01:P0:+HZZZhb51+E=;ZGUkJZ0ZS7Ra/mVgOr7/Q4AJTlQ
 4uRBMi0Qum7qyTKHCzdw4o+XrTO6DGjhSrUV+KbRtxV4gQ6BhsTgAd8VAfzoy39iUwo5pNww3
 Y+1ksKjRhUeLNlyhf0h5cU1a8Qvc1y0TJVwpHwCSLU8uYwSbqxD63sowS7PBG1Ib52yd5co6j
 702q906vnRWPl8CrfxKUN/5rIlNSgkA/yNwzm2NWLO84OeuZ0lBWnP7oJ0aosQFUXFwhyDoK4
 0EPUwwltw6eQnVRf04UJCcH9oFxK8aatiRKe8RpPVhICpq2TnUnlNi7atb3K5Vwa8rgrSoioz
 0pcq4z7i49iNriz3V7LvpZc3VScKUDp0bbCT/rqwc4bTSAqdb8eMU4E/hiiEzKTWkVBQd7TRp
 WUTCHs4WT3xtCW1jCWO6ehRDZY9qVyYod8+6SVmXs6pe9tv2gQx7U2nDBrliABRKSGw0ChlKr
 43JilMK2pGtHD+z1Pc1tsOD+zCxe66sUj1iiZjblWvQ1yyGti5WtQ71tHpmtXk7lX/z15WCuL
 hTetCEhLcvvxENnBfVLolZlta+u7JujToiwW6+qBmVTOD72zZ3FpMNZ45ssz1x8Wig//gE2B0
 pseORzxPctHyxrMWRIru/2s7pjZvpeuJ0sDZDb4u7DeyKzK23Lzpx+rH5y6SCppames85j8WS
 4UDRpT64bvl41K3q0Ro6K7IKqbusXFKD9N8BhBJvjw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Peter,

could you please provide a "bad case" file list of all firmware files 
for the Raspberry Pi 3 B+ which worked before Linux 6.1, so i can 
reproduce it?

Also OpenSuSE seems to be affected [1].

[1] - https://bugzilla.suse.com/show_bug.cgi?id=1206697

Regards
Stefan

