Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1FD198EBC
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2020 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgCaIlu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Mar 2020 04:41:50 -0400
Received: from sonic305-1.consmr.mail.bf2.yahoo.com ([74.6.133.40]:37837 "EHLO
        sonic305-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgCaIlt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Mar 2020 04:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585644107; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dCbcCfrWHaSHWW+Z7sIkoJlnUCbNAI8HpaePpxEUrPyvLUiOyaJL5oQB4AAowoYKxDTHK0fjahBTH//uQDHwByDrdBDp6CfqHp4SawZEDDi4vaPAjsRDTfzzTDDkNwLhkrHnLO1iieDRf+za3nz02x1awqL8l2aqtx9frUbH0TVDeqRls+s+G6JxsS5Ave9ciS0UnCDjJQbdW71eD5UuupCvexKefZ4Ydn7LR2mlRuKfttN0f0oWcHxzx9Ck2xn8fVftDf9r2w8gFEOc4sAeGBCpwE/wztWfGnznCZwcNdz69QuFub822l0w4AWfVjTrBGn2rcHnsllaoTCcekYH6g==
X-YMail-OSG: EDdxICQVM1n.cXw02ESCPzHcKo_g7gSpVnVdDsajyajOODPFgbMyz2KGvW2yPIo
 O4kcePdIM7Jx7j2aZLR5nFfG5h2_99OArj_3evo69xxNW7uO0Z.Xqxfg8ncE179d0PPPcb_NZ3rc
 xr2POYGONu1jDckZYcSzFWB_.FrQ0dkXQFQwHz6ywjWPBbnwc5EyQHKK9thQPfbR0ybwF3L5Ujfp
 k_8rhQh.3CRPBNPc3.EsX7YaKbu3dIMF2hK8JXcwqEbm5o719cb_NZA42JTFEN03KqSs1ODhL0ZT
 P8bNS1tvrXoXfGWvuiYtdE5P7wSFPhYvOU3zGgZ0idwbiGZMRVLq4_K4P2hHEi.MIga..PpSWgix
 GDB4zCq69bGjhoWMO..mVjRTx8a6P6_vpRME0o.MqojfV62lv32m.NhVUcafLfNt_yVV7r7zOcwG
 cSZ0FqEfZHQuY9cYou0Op004jV934rz.XYpRjBACtiG2HQ0ikHcmbhi1bqZlKdS_4E8s_9Bhv4cd
 95RaFZk0cq3.1XdFvnMmxPZiOh_94tsRhHIUrv_KankgWQ4lAptw4zjc6fuRszFKah1tIMCDdazB
 Y1BlcUyRXV9sc3cH7NAoepxLbgmvtMBiANGA2_TZGZmVBw18rQtGjtGcRpyzXaX4D5qayWgLx3Nj
 v__oEyADDdIuNjpDZh3iP7t7kjixD4Xqul8Tuyzpl79an03z1em5ro9pHETlW02iNOuQFxjfP6Fk
 JPX7.AbZvAXy3H9g_kVwtdAIx5SqRQGtw3zfm4K671S_rbcv1IwHAS_wEBIErOWwuB6UB7B9kwPx
 pT3bjqECjOoL.jtBw9xo_So1qAqDkxTCbwN.9Dj_OJvCHbFMmbu2a0u1Iqeu5ocphVYGM57FliTx
 HuOGgHRB8Z3pUnDOrxFDGvhkJY3jnyOdnhm_xExVVJhxrvKI0XQkwHGLw_P2fMsaDpOuOwW8.xX0
 FaKABKKQtCZj9ACl9pfWq4kzza4kUwUiKr7V52UfifbtalfcYwKdh0EvK5H4peoVN3Y_N4rkmKp0
 Hqj0DMoC97NADoUOff_DqtTQMYl9NL8h8.N9szU7ih15w8lA5XqydzwnkY7L_842B9DvRLgGTiEy
 2uMO3ingA36ZXI8T_kwpdbtkgd7_abPjkzMmiBHmy9HyFAfL8Uz8mZbAmEcmJ5RrKZFIaYPr_MLG
 4KLLCgPRu.D6h41tRvuSZKO7GoXUex_ABgS8foPiKpfMfboeZ4S4Y4_jDD0wCNv3vAUjI1Ar8vFQ
 MqcAikkrEGEa1h40bB7QGeVupqEVlD.NfzNjOevkiAcsjgLhkUUlQ9llSHQN.BGOq5ZxmcoQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Tue, 31 Mar 2020 08:41:47 +0000
Date:   Tue, 31 Mar 2020 08:41:43 +0000 (UTC)
From:   Ms lisa Hugh <lisahugh531@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <3971412.1036975.1585644103007@mail.yahoo.com>
Subject: BUSINESS CO-OPERATION OPPORTUNITY.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <3971412.1036975.1585644103007.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15555 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
