Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E194D774206
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjHHRcn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 13:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjHHRbo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 13:31:44 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695621E59
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:13:44 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691502172; bh=5ydHpp39bvPVwbOtGyEeLGh0RRaoR5CKjd5o/SJ7NRk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WsvVs/04B8SbDkksfWKRXGu75lVIp43UqSdjuDZ2tWEbCHcWKFsafvGjRC4KdCk9b
         KMSaFxfz6kWZuiiLH43Fpp16ZSh84+5n0mSdblpyj9L/J+9FCa3G7kigeDTxSaaFZx
         r6/IHbITlZVwaALMjkPZKbpXMQGpZAM2iW2IZwxlnLJ9NtdFWdRDYivRDqK68u7P8l
         zjwC8sGXXlk6861E6+syWQN4cUsep+vVLqiv3Jbfo9CxAFXQlqrD1IwXiJhT4Vroft
         DYNXWTKxDMS4QtUszVGekI3Er2FgY57W8hzsCirHfEDQNwIMoeMLsJZYNQ+LvRKtoH
         3O60kHsTsmNQw==
To:     Ruan Jinjie <ruanjinjie@huawei.com>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Cc:     ruanjinjie@huawei.com
Subject: Re: [PATCH -next] ath9k: Remove unnecessary ternary operators
In-Reply-To: <20230731124455.2039184-1-ruanjinjie@huawei.com>
References: <20230731124455.2039184-1-ruanjinjie@huawei.com>
Date:   Tue, 08 Aug 2023 15:42:52 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87h6p9bqg3.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ruan Jinjie <ruanjinjie@huawei.com> writes:

> Ther are a little ternary operators, the true or false judgement
> of which is unnecessary in C language semantics.
>
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
