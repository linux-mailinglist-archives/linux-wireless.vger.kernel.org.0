Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FBF10EBE0
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2019 15:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfLBOyw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Dec 2019 09:54:52 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:40394
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfLBOyw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Dec 2019 09:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575298492;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=1BQ4r9/xpX+9Yw4USyRxqrSypd0XnWFg2wq//swz0nw=;
        b=etLMqc9UJ0zmDtuMIadWs8Sb1RChIeZgGej9WPbOKeF2Gufm5Gvss3DJPv6ydZOi
        2oMkV+bf5r9UJ7O8xae3cmdmBM5abmugTMAWp+mUo1oNeridO2HvO2hCKaNFE45bm/3
        3j9eNaZEJu6MsN9gSBv+dPSupyVLYWYP9Fp/ZJ8c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575298492;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=1BQ4r9/xpX+9Yw4USyRxqrSypd0XnWFg2wq//swz0nw=;
        b=PEg3mC3nuT24XICZbhLIEugfHq3s5Ry76eMNC3sJQgVwnaR9TsIp97Bcs+IYYkHy
        RxMcOVyDuPY5kdAk1iwiFQadtmYvGDFa/xFMKkC4C/gyZTmvpeYqzWTLqsPwa8b2sbC
        XgsrDMSyD/IbkJIdIcrbWgCAbPkk/+60zDsFcOlA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1F2DC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     qize wang <wangqize888888888@gmail.com>
Cc:     linux-wireless@vger.kernel.org, amitkarwar@gmail.com,
        nishants@marvell.com, gbhat@marvell.com, huxinming820@gmail.com,
        kvalo@codeaurora.org, greg@kroah.com, dan.carpenter@oracle.com,
        solar@openwall.com
Subject: Re: [PATCH v3] mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_frame()
References: <20191129101054.2756-1-wangqize888888888@gmail.com>
Date:   Mon, 2 Dec 2019 14:54:52 +0000
In-Reply-To: <20191129101054.2756-1-wangqize888888888@gmail.com> (qize wang's
        message of "Fri, 29 Nov 2019 18:10:54 +0800")
Message-ID: <0101016ec71b6643-65bb0c52-29a0-456e-aa6d-6a4649e28a03-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SES-Outgoing: 2019.12.02-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

qize wang <wangqize888888888@gmail.com> writes:

> mwifiex_process_tdls_action_frame() without checking
> the incoming tdls infomation element's vality before use it,
> this may cause multi heap buffer overflows.
>
> Fix them by putting vality check before use it.
>
> IE is TLV struct, but ht_cap and  ht_oper aren=E2=80=99t TLV struct.
> the origin marvell driver code is wrong:
>
> memcpy(&sta_ptr->tdls_cap.ht_oper, pos,....
> memcpy((u8 *)&sta_ptr->tdls_cap.ht_capb, pos,...
>
> Fix the bug by changing pos(the address of IE) to
> pos+2 ( the address of IE value ).
>
> v3: change commit log
>
> Signed-off-by: qize wang <wangqize888888888@gmail.com>

Applied manually (removed the changelog from commit), thanks.

1e58252e334d mwifiex: Fix heap overflow in mmwifiex_process_tdls_action_fra=
me()

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
