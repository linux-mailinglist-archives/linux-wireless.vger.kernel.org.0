Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E4663F152
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiLANNp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 08:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiLANNo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 08:13:44 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F39E45D
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 05:13:42 -0800 (PST)
Received: from [192.168.0.66] ([92.154.77.116]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M8QiW-1p59Dz3kcy-004UbH; Thu, 01 Dec 2022 14:13:35 +0100
Message-ID: <f2226065-b307-1312-61f1-827bb709cf92@green-communications.fr>
Date:   Thu, 1 Dec 2022 14:13:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <b305eea9-3dd5-0e5e-7726-0eb7c6d0e242@nbd.name>
 <166989085154.28651.16470485299307034951.kvalo@kernel.org>
From:   Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Subject: Re: pull request: mt76 2022-11-28
In-Reply-To: <166989085154.28651.16470485299307034951.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fCcvO8UIt/FPXdlaREPMbwepwThhlIJkQN+3XkLdcd/Jvq4XKIf
 Lxp/LtziC5euD/td9z3Hz8u0g8zvkZ4hAeWYe71V80FfoMaALpIFN+pvgxLXwQfuYbbZ1++
 wYZlkVlfZgQ3SZty/avReoCpIv8Ka6LZtWtnWasOr6A7Ay7HyxVoWXwoibBHlCHZOySU+yi
 dU1TC4mnpPHCnHUm8OAyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Emkqoguk71g=:T3oAScU8GaDfx2IA7J9s8B
 Fxa/WtT1mlqFjXc49xKj87W/wezESQ0++LXBXJ5mlisnj1llxUve9aiiuTLXX68oP/Sujx5mx
 YzS+HT3RmT60bf+lfyjR7spdIdEdPVYE3Uf3mkOOz5BGP0l0UtaYngflFq+Np3T5pWS6XVoOZ
 7nPFu6N7riBBff1lQTEPbcMuxcertBrrnkvzdZeSVFylehOrWX19AS6KiQaktGWA2Yjqmpqxj
 YaVTdW8Z7i4+QRA2uvauWvBX577wSUoZCSB9BBJtCta1P8dM4W7JsVvzI6Xu/rW9wiUsVITrY
 FMVU8rGhpDH5GGqf9lTUXGBVrw3IOi2s/2IeV/xj4RiL/ouCYLMNhtJNzMbZZ/ipN8n05Dcmi
 Ddy+ZIohugbQC9RFgmeuMLw2zWzZA44myjG6zUR2JZ0YmuMNKwzaTRCSuB1G15IfNfootCLA4
 Hwr6kgHAN18Zj3SpVsWD/rMowwwskMuf2wEVmh1qbQqr9u4+olCXvYFS1WuofKfO03V3OiDdn
 qMMOOj4veJ5xnO7ebvxmKQtnug1SRkjI0b2RotBEHQbz1O6eIpnbGR4ts26HMC2RDzq80cxuO
 wQErOJYlj+AWJBIiHOG4I4niTC1e2z4km7jh/yjzXg+rhByQUTsOAW35gx030GKrXTLY8s5ik
 ZpM47/trf3y2R4rytL8sdE8Al92+Uh287DKyfexwIbZhHLZNb8eGqgXFSWlrQ5yeq56Jefy1L
 W8q7Xyv7Rl2XJX5GH9hO+/+XdG1tvSjjpb4nhhzaTDGjM9uhjQFkFjN09oQqaeEItGhR/CfyA
 nzWBAkV6sGmVa801JM25vDVq9utubfWRPG4iPn1g1ejYdZCT8w=
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 01/12/2022 11:34, Kalle Valo wrote:
> I see two problems with Fixes tags:

Sorry about that.

It's hard to reference commits from a branch that gets rebased.
