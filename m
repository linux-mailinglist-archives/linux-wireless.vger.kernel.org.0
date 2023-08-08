Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2770774CCA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 23:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbjHHVSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235879AbjHHVRq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 17:17:46 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B18527E
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 13:13:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686f1240a22so5878914b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Aug 2023 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691525638; x=1692130438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSDFPRHM/WG5qXppgSueGIee7lwvREuORa1Ou3dpkk4=;
        b=jwa+AZyU3TOifP5EErh6brnOqttqoqd5dfljAV4dAqIUVjYJxHVIA0dxniwgtUbkeO
         emqnJM5sivlQHv4tavBEd0pBrZfN72994m1iO7WudU4ATOdcLqNndyHQ9aSvypOwAkVU
         9yh1IGm1h40zNDuigvES5CEXCYulil6FFd2Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525638; x=1692130438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSDFPRHM/WG5qXppgSueGIee7lwvREuORa1Ou3dpkk4=;
        b=YAy+N6BHo0kiiePI1eL3OJU9GDd8w/kiyU22Hog3WICpZ/ymGkqEixvKGcMa1EKtPb
         jHq4UX+m9QNlL/f2cYOi+Eras0JUMZBC9EMLKMnKGp82NwusIMRldviwFqxu07QyctcU
         +uTBMdcxpPdlCSBba7CkIKzgHJdHBC+CS1pZ4X71Y3U6NwUW0RbxfR5CZiZhwZbztS3q
         TiDNWd7OK2E9tHI3nBieTE8vN6MZBR9kwQ97OsDFcjyco28y+NZk+++889ZXjAp7S93J
         WOxvRTaZMCj1kSo5alhfKFE1kNrw82z1gN2WFlDwwVI3mUFNGDrFcKnqaNBfGZ0p4cHO
         3vWQ==
X-Gm-Message-State: AOJu0YwptPB8iQtbzDuZtSUgSxrgMEKRxo4hDkO6UrB4jzCrmtsIUaoF
        awjmaGTX8TzoMt8rwkEcZo7FzA==
X-Google-Smtp-Source: AGHT+IET6nT6clgIC+ZXYU0yC5p20xzPQybJ51TtsbD0KHGY8hC6hspDgab3faVrBZdjglw8H/TDpw==
X-Received: by 2002:a05:6a20:1055:b0:137:a3c9:aaa2 with SMTP id gt21-20020a056a20105500b00137a3c9aaa2mr537198pzc.30.1691525638464;
        Tue, 08 Aug 2023 13:13:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:800e:831a:c5f6:2dd0])
        by smtp.gmail.com with ESMTPSA id fe11-20020a056a002f0b00b00682a99b01basm8507447pfb.0.2023.08.08.13.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:13:57 -0700 (PDT)
Date:   Tue, 8 Aug 2023 13:13:56 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     kvalo@kernel.org, christophe.jaillet@wanadoo.fr,
        simon.horman@corigine.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH -next RESEND] wifi: mwifiex: use is_zero_ether_addr()
 instead of ether_addr_equal()
Message-ID: <ZNKiBE3GIi/wQXLB@google.com>
References: <20230808081023.2303423-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808081023.2303423-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 08, 2023 at 04:10:23PM +0800, Ruan Jinjie wrote:
> Use is_zero_ether_addr() instead of ether_addr_equal()
> to check if the ethernet address is all zeros.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Usually you should provide some explanation for a RESEND of a
seemingly-identical patch. Seemingly you just updated the address list?

Anyway, looks fine:

Acked-by: Brian Norris <briannorris@chromium.org>
