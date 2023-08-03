Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C176EB3E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 15:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbjHCNyI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 09:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjHCNyH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 09:54:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114861722
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 06:54:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F6F61DAC
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 13:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E8C433C9;
        Thu,  3 Aug 2023 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691070843;
        bh=2zndGpTW3ZG0uaaqaVtbSxN+xzTy4HQzh1W7lEh+UII=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eljg5XsEByTElk9FWxj66hON4KRf6wEx9aq3ngYXSAXGcf2vNMayxyi6a/SHGOcdC
         a8m7uupwp3lOjgnQWZdfVH3cKYA/ywYFURVYOzEcBOkWGwVrVxM/WjuZ585h/so7IB
         9Ne+6Kfw1beI3wJndMEJ5qIHEOod3JlT9GuICdZBMEs/000Xq15Q2WwpEPYpejEICg
         Kimp8m4jHbFGYqtoN+7f9aY5VYzHH338g4XQfoQfcGLK7jPzPCNXcJvYDS++UBh+Cm
         zYb+K4+++6gec3sqhlYvg9Zinj2r/huvzJqN56M/W3wdfI71FCpp8T8ME4JrLxHdtx
         nowha7IAQeFmQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Subject: Re: ath12k: memcpy() source buffer overread
References: <5c114ed7-6e8a-76a7-c0da-4193d1288686@yandex.ru>
Date:   Thu, 03 Aug 2023 16:54:00 +0300
In-Reply-To: <5c114ed7-6e8a-76a7-c0da-4193d1288686@yandex.ru> (Dmitry
        Antipov's message of "Tue, 20 Jun 2023 09:18:03 +0300")
Message-ID: <875y5wteo7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ ath12k list

Dmitry Antipov <dmantipov@yandex.ru> writes:

> When compiling with gcc 13.1 and CONFIG_FORTIFY_SOURCE=3Dy, I've noticed =
the following:
>
> ...
> In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>     inlined from =E2=80=98ath12k_peer_assoc_h_he=E2=80=99 at drivers/net/=
wireless/ath/ath12k/mac.c:1640:2,
>     inlined from =E2=80=98ath12k_peer_assoc_prepare=E2=80=99 at drivers/n=
et/wireless/ath/ath12k/mac.c:2027:2:
> ./include/linux/fortify-string.h:529:25: warning: call to =E2=80=98__read=
_overflow2_field=E2=80=99 declared with
> attribute warning: detected read beyond size of field (2nd parameter); ma=
ybe use struct_group()?
> [-Wattribute-warning]
>   529 |                         __read_overflow2_field(q_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>     inlined from =E2=80=98ath12k_peer_assoc_h_he=E2=80=99 at drivers/net/=
wireless/ath/ath12k/mac.c:1643:2,
>     inlined from =E2=80=98ath12k_peer_assoc_prepare=E2=80=99 at drivers/n=
et/wireless/ath/ath12k/mac.c:2027:2:
> ./include/linux/fortify-string.h:529:25: warning: call to =E2=80=98__read=
_overflow2_field=E2=80=99 declared with
> attribute warning: detected read beyond size of field (2nd parameter); ma=
ybe use struct_group()?
> [-Wattribute-warning]
>   529 |                         __read_overflow2_field(q_size_field, size=
);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
>
> And this seems correct because:
>
> /* dst: u32[2], src: u8[6], size: 8 so 2 byte source overread */
> memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
>        sizeof(arg->peer_he_cap_macinfo));
>
> and:
>
> /* dst: u32[3], src: u8[11], size: 12 so 1 byte source overread */
> memcpy(&arg->peer_he_cap_phyinfo, he_cap->he_cap_elem.phy_cap_info,
>        sizeof(arg->peer_he_cap_phyinfo));

Arnd fixed this:

https://git.kernel.org/kvalo/ath/c/603cf6c2fcdc

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
