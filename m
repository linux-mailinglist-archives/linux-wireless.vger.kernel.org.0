Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB83B192673
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCYLAq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 07:00:46 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60120 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727137AbgCYLAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 07:00:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585134045; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=mHjWNEnv5917EKxAOANEuTjIJkXbIPTe1KiHqOWLln0=; b=VqhXToR+mZM6yRJkNIuT4DFtVGeKBcArfwImvTcIMT9zu66FbeLK2QcWJBnb+bW5k1Y/gie7
 v02582NC4Ny6UzXdlWuqQWQZM/Q/+N2dtEnJNRCVNRVwf97Yojib5JDWr7a2dNG0kya2qGd8
 YCByfSM+oL42lQ27LSnSzaxGpUs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7b39d2.7f5a07298f48-smtp-out-n04;
 Wed, 25 Mar 2020 11:00:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BCD4C43636; Wed, 25 Mar 2020 11:00:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from Pillair (unknown [183.83.66.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3362EC433D2;
        Wed, 25 Mar 2020 11:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3362EC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   <pillair@codeaurora.org>
To:     "'Kalle Valo'" <kvalo@codeaurora.org>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1585054044-18667-2-git-send-email-pillair@codeaurora.org> <20200324141404.C9A7FC432C2@smtp.codeaurora.org>
In-Reply-To: <20200324141404.C9A7FC432C2@smtp.codeaurora.org>
Subject: RE: [PATCH 1/3] dt-bindings: ath10k: Add wifi-firmware subnode for wifi node
Date:   Wed, 25 Mar 2020 16:30:25 +0530
Message-ID: <000001d60294$9abcfb20$d036f160$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIav5wwSpfWqpn79mByT9bYGdzwAAIfXdf4p76udaA=
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

I had tested it on a slightly older ath10k tree, and missed a few =
cleanup while rebasing it on the ath10k tree tip.
I have now fixed these build errors and will send out v2 for this =
patchset.

Thanks,
Rakesh Pillai.

> -----Original Message-----
> From: Kalle Valo <kvalo@codeaurora.org>
> Sent: Tuesday, March 24, 2020 7:44 PM
> To: Rakesh Pillai <pillair@codeaurora.org>
> Cc: ath10k@lists.infradead.org; linux-wireless@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Rakesh =
Pillai
> <pillair@codeaurora.org>
> Subject: Re: [PATCH 1/3] dt-bindings: ath10k: Add wifi-firmware =
subnode for
> wifi node
>=20
> Rakesh Pillai <pillair@codeaurora.org> wrote:
>=20
> > Add a wifi-firmware subnode for the wifi node.
> > This wifi-firmware subnode is needed for the
> > targets which do not support TrustZone.
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
>=20
> Fails to build and has warnings. How did you test this?
>=20
> drivers/net/wireless/ath/ath10k/qmi.c: In function
> 'ath10k_qmi_msa_mem_info_send_sync_msg':
> drivers/net/wireless/ath/ath10k/qmi.c:160:23: error: 'struct =
ath10k_qmi' has
> no member named 'msa_pa'
>   max_mapped_addr =3D qmi->msa_pa + qmi->msa_mem_size;
>                        ^~
> drivers/net/wireless/ath/ath10k/qmi.c:160:37: error: 'struct =
ath10k_qmi' has
> no member named 'msa_mem_size'
>   max_mapped_addr =3D qmi->msa_pa + qmi->msa_mem_size;
>                                      ^~
> drivers/net/wireless/ath/ath10k/qmi.c:163:41: error: 'struct =
ath10k_qmi' has
> no member named 'msa_mem_size'
>    if (resp.mem_region_info[i].size > qmi->msa_mem_size ||
>                                          ^~
> drivers/net/wireless/ath/ath10k/qmi.c:165:48: error: 'struct =
ath10k_qmi' has
> no member named 'msa_pa'
>        resp.mem_region_info[i].region_addr < qmi->msa_pa ||
>                                                 ^~
> make[5]: *** [drivers/net/wireless/ath/ath10k/qmi.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
> In file included from ./include/linux/byteorder/little_endian.h:5,
>                  from ./arch/x86/include/uapi/asm/byteorder.h:5,
>                  from ./include/asm-generic/bitops/le.h:6,
>                  from ./arch/x86/include/asm/bitops.h:395,
>                  from ./include/linux/bitops.h:29,
>                  from ./include/linux/kernel.h:12,
>                  from ./include/linux/clk.h:13,
>                  from drivers/net/wireless/ath/ath10k/snoc.c:6:
> drivers/net/wireless/ath/ath10k/snoc.c: In function
> 'ath10k_msa_dump_memory':
> drivers/net/wireless/ath/ath10k/snoc.c:1424:54: error: 'struct =
ath10k_qmi'
> has no member named 'msa_va'
>   hdr->start =3D cpu_to_le32((unsigned long)ar_snoc->qmi->msa_va);
>                                                       ^~
> ./include/uapi/linux/byteorder/little_endian.h:33:51: note: in =
definition of
> macro '__cpu_to_le32'
>  #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
>                                                    ^
> drivers/net/wireless/ath/ath10k/snoc.c:1424:15: note: in expansion of =
macro
> 'cpu_to_le32'
>   hdr->start =3D cpu_to_le32((unsigned long)ar_snoc->qmi->msa_va);
>                ^~~~~~~~~~~
> drivers/net/wireless/ath/ath10k/snoc.c:1425:40: error: 'struct =
ath10k_qmi'
> has no member named 'msa_mem_size'
>   hdr->length =3D cpu_to_le32(ar_snoc->qmi->msa_mem_size);
>                                         ^~
> ./include/uapi/linux/byteorder/little_endian.h:33:51: note: in =
definition of
> macro '__cpu_to_le32'
>  #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
>                                                    ^
> drivers/net/wireless/ath/ath10k/snoc.c:1425:16: note: in expansion of =
macro
> 'cpu_to_le32'
>   hdr->length =3D cpu_to_le32(ar_snoc->qmi->msa_mem_size);
>                 ^~~~~~~~~~~
> drivers/net/wireless/ath/ath10k/snoc.c:1427:40: error: 'struct =
ath10k_qmi'
> has no member named 'msa_mem_size'
>   if (current_region->len < ar_snoc->qmi->msa_mem_size) {
>                                         ^~
> drivers/net/wireless/ath/ath10k/snoc.c:1428:27: error: 'struct =
ath10k_qmi'
> has no member named 'msa_va'
>    memcpy(buf, ar_snoc->qmi->msa_va, current_region->len);
>                            ^~
> drivers/net/wireless/ath/ath10k/snoc.c:1430:41: error: 'struct =
ath10k_qmi'
> has no member named 'msa_mem_size'
>         current_region->len, ar_snoc->qmi->msa_mem_size);
>                                          ^~
> drivers/net/wireless/ath/ath10k/snoc.c:1432:27: error: 'struct =
ath10k_qmi'
> has no member named 'msa_va'
>    memcpy(buf, ar_snoc->qmi->msa_va, ar_snoc->qmi->msa_mem_size);
>                            ^~
> drivers/net/wireless/ath/ath10k/snoc.c:1432:49: error: 'struct =
ath10k_qmi'
> has no member named 'msa_mem_size'
>    memcpy(buf, ar_snoc->qmi->msa_va, ar_snoc->qmi->msa_mem_size);
>                                                  ^~
> drivers/net/wireless/ath/ath10k/snoc.c: In function =
'ath10k_fw_deinit':
> drivers/net/wireless/ath/ath10k/snoc.c:1593:14: error: assignment of =
read-
> only variable 'mapped_size'
>   mapped_size =3D ar_snoc->fw.mapped_mem_size;
>               ^
> drivers/net/wireless/ath/ath10k/snoc.c:1599:46: warning: format '%d'
> expects argument of type 'int', but argument 3 has type 'size_t' {aka =
'long
> unsigned int'} [-Wformat=3D]
>    ath10k_err(ar, "failed to unmap firmware: %d\n",
>                                              ~^
>                                              %ld
>        unmapped_size);
>        ~~~~~~~~~~~~~
> make[5]: *** [drivers/net/wireless/ath/ath10k/snoc.o] Error 1
> make[4]: *** [drivers/net/wireless/ath/ath10k] Error 2
> make[3]: *** [drivers/net/wireless/ath] Error 2
> make[2]: *** [drivers/net/wireless] Error 2
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
>=20
> 3 patches set to Changes Requested.
>=20
> 11455345 [1/3] dt-bindings: ath10k: Add wifi-firmware subnode for wifi =
node
> 11455351 [2/3] ath10k: Setup the msa resources before qmi init
> 11455353 [3/3] ath10k: Add support for targets without trustzone
>=20
> --
> https://patchwork.kernel.org/patch/11455345/
>=20
> =
https://wireless.wiki.kernel.org/en/developers/documentation/submittingp
> atches

