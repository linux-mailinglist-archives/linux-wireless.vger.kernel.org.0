Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8272DD5E
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 11:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbjFMJMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbjFMJMH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 05:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BEB18E
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 02:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F6962BB1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 09:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFE6C433D2;
        Tue, 13 Jun 2023 09:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686647526;
        bh=/4eEw0uGb4AMVuNQlMhLFv26NmahrfFuwAqDuFkydpo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iEnY7Jx/cwmkD0jQBRieuutfw+mpkdzou90y3riemVpjmfQCLDO8uG6tcH1vob9rJ
         5Nm/GgTOed+Wr12+IncMYygfEEf+K6zwP14CzkOQoxxOp7h5xkknN42ElsQOL0w0Tk
         OrwECpmbP3rJ4wpbeK57HNwG8OTEw1hTE23ZBv2BW3ilY7K/s9MFMiUgClS9tDLbKk
         SwoLY3AIRR7KhuqcHSqhFBQSUGVIV7y7sdWob0TgZKUnwKUXKndziozodZ37B2/NSC
         GAeocGTagHd9B+6GkkLaPFaKNATt/4dnpaqm6vXLiTE700zW8nPG7nvTtd+6VIU6W8
         neGPLR/+hM5ag==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] [v3] wifi: rtw89: cleanup private data structures
References: <20230608082457.36020-1-dmantipov@yandex.ru>
        <168664549483.24637.5306969377701572999.kvalo@kernel.org>
        <975dee84-fa8f-1dbd-a2b8-2aba5a880b60@yandex.ru>
Date:   Tue, 13 Jun 2023 12:12:03 +0300
In-Reply-To: <975dee84-fa8f-1dbd-a2b8-2aba5a880b60@yandex.ru> (Dmitry
        Antipov's message of "Tue, 13 Jun 2023 11:56:24 +0300")
Message-ID: <877cs7enfg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> On 6/13/23 11:38, Kalle Valo wrote:
>
>> Failed to build
>
> Hmm... works for me against upstream at fb054096aea0 using following configuration:
>
> CONFIG_RTW89=m
> CONFIG_RTW89_CORE=m
> CONFIG_RTW89_PCI=m
> CONFIG_RTW89_8852A=m
> CONFIG_RTW89_8852B=m
> CONFIG_RTW89_8852C=m
> CONFIG_RTW89_8852AE=m
> CONFIG_RTW89_8852BE=m
> CONFIG_RTW89_8852CE=m
> CONFIG_RTW89_DEBUG=y
> CONFIG_RTW89_DEBUGMSG=y
> CONFIG_RTW89_DEBUGFS=y

You should use wireless-next as the baseline for wireless patches:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
