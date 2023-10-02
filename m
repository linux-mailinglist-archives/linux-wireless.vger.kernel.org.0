Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958927B4B3F
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Oct 2023 07:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjJBFyx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 01:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJBFyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 01:54:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B8AD
        for <linux-wireless@vger.kernel.org>; Sun,  1 Oct 2023 22:54:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230ACC433C7;
        Mon,  2 Oct 2023 05:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696226090;
        bh=ERF2+vPdR5zxPHbWiNc4FxQ0Iz4NyDB2w/HuJMATH4s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HZ1DYgTSpwQ1za5nyanJS2F9qUz7QoyjWSrS6iSS5YQzFWbqt6TiTp48ekW8foHvv
         5sedgHf/veTEGmgXau1fheBaP7eYSeELQO9dw4MhTjRtg0s5AaWhEE6MOMYvj2IM4X
         3JQC9a94aIWHU87sGHhIR2eEFNE4h6j4aVtkNscT9ODB5zxe2wAM8qNzcOXF8+o6Fl
         p/UFdj//BQuftU5XP2rKJ7i6Ki157cw+zElTH4XfqrMbPyZ/H4bGGron234I173Q+j
         T8lTtZLh7EtqqdNY+6x8FCW+KpwoaRhAySXQO4Xx9z0FEtJliF4h76Ut9Y8m7l1B/U
         UkGc4acvLV/cw==
From:   Kalle Valo <kvalo@kernel.org>
To:     =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Cc:     "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        =?utf-8?Q?Mingyen_Hsieh_=28=E8=AC=9D=E6=98=8E?=
         =?utf-8?Q?=E8=AB=BA=29?= <Mingyen.Hsieh@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TGVvbiBZZW4gKOmhj+iJrw==?= =?utf-8?B?5YSSKQ==?= 
        <Leon.Yen@mediatek.com>,
        =?utf-8?Q?Rong_Yan_=28=E9=84=A2=E8=8D=A3=29?= 
        <Rong.Yan@mediatek.com>,
        =?utf-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>,
        =?utf-8?B?U3RlbGxhIENoYW5nICjlvLXmm4nkvakp?= 
        <Stella.Chang@mediatek.com>,
        =?utf-8?Q?Quan_Zhou_=28=E5=91=A8=E5=85=A8?= =?utf-8?Q?=29?= 
        <Quan.Zhou@mediatek.com>, Sean Wang <Sean.Wang@mediatek.com>,
        =?utf-8?B?S00gTGluICjmnpfmmIbmsJEp?= <km.lin@mediatek.com>,
        =?utf-8?B?U291bCBIdWFuZyAo6buD6Iez5pi2KQ==?= 
        <Soul.Huang@mediatek.com>,
        =?utf-8?B?UG9zaCBTdW4gKOWtq+eRnuW7tyk=?= <posh.sun@mediatek.com>,
        =?utf-8?Q?Eric-SY_Chang_=28=E5=BC=B5=E6=9B=B8=E6=BA=90=29?= 
        <Eric-SY.Chang@mediatek.com>,
        =?utf-8?B?Q0ggWWVoICjokYnlv5fosaop?= <ch.yeh@mediatek.com>,
        =?utf-8?B?Um9iaW4gQ2hpdSAo6YKx5ZyL5r+xKQ==?= 
        <robin.chiu@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] wifi: mt76: mt7921: support 5.9/6GHz channel
 config in acpi
References: <cover.1696039301.git.deren.wu@mediatek.com>
        <f01bcf001c896a74e36ac9905bece382efb13b0d.1696039301.git.deren.wu@mediatek.com>
        <0a45200ad39209d8955b5580b0d36444d7c5ad5a.camel@mediatek.com>
Date:   Mon, 02 Oct 2023 08:56:59 +0300
In-Reply-To: <0a45200ad39209d8955b5580b0d36444d7c5ad5a.camel@mediatek.com>
        ("Deren Wu =?utf-8?B?KOatpuW+t+S7gSkiJ3M=?= message of "Sat, 30 Sep 2023
 03:02:46 +0000")
Message-ID: <87o7hhin2s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Deren Wu (=E6=AD=A6=E5=BE=B7=E4=BB=81)" <Deren.Wu@mediatek.com> writes:

> On Sat, 2023-09-30 at 10:25 +0800, Deren Wu wrote:
>> From: "rong.yan" <rong.yan@mediatek.com>
>
> Hi Felix,
>
> I am not sure why this patch is not shown in wireless patchwork, but it
> is mediatek patchwork alreay. Guess there is something wrong in
> author's naming parsing. I prefer to keep this patch in mail thred only, =
how do you think?

The patch is also available in lore:

https://lore.kernel.org/all/f01bcf001c896a74e36ac9905bece382efb13b0d.169603=
9301.git.deren.wu@mediatek.com/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
