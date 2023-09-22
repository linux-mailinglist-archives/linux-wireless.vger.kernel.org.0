Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A097AB3EB
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjIVOlX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjIVOlV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 10:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3AFCF5
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695393626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGnMCyubh7bE+/HJGj4DK0rgvnpm1pyHq1+UZD2NCjY=;
        b=VbVQRiN3J/8nbxfz7R4heChBOhXHRhGrmGAQf+26ocGHC2KzkAtks7TjjuINyvc8fYlMZT
        6IvKhyp2rJKFsOyZ/a0XWnMZEKGXTYVc9RZ/WPNgyGWaywZrqv1LRB5Je4bSqvp7RfWAkY
        +sOsKYetEPUt+JmYCG1jFgjKWO5ajE4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-o0b7w06JMqOM5b56DFhyOQ-1; Fri, 22 Sep 2023 10:40:25 -0400
X-MC-Unique: o0b7w06JMqOM5b56DFhyOQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-530a085c62dso159331a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 07:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695393624; x=1695998424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGnMCyubh7bE+/HJGj4DK0rgvnpm1pyHq1+UZD2NCjY=;
        b=mTCu4e6H5KGk00UUpM03qlgHfitOQWqe2qS6x2sC0BlgxxXbI0jZ7X5xT6JFsCcCdm
         VJCLRiTm4uBHUiakT1WSRju2eLy9JIq6nKMuwUK5K+0i0PzqnqJk4MK5U235PYpSCi1G
         4GXnW3QzS+Lbg6KmlprPuMlllr4DtfeUoox2069jzmYSP5Nntc2XThVdCov5l4goqmzq
         v0bFyFhw9ukqw9pBD2T+KgUxZthOvGKrfyAB/ag6k/FHrfiUFx5WyIUL+SQnzGuj5ANb
         54sVxys7Var3MCAXtbk4YP4mQDpN7cIj8NvozU9XnAZgibGJr8BdiuEd7INQFk/oxy3W
         BTgQ==
X-Gm-Message-State: AOJu0YzY9EZQz3HYf8yIpFcmVRb/qYnpVfOvRcjmxKy7zHWqKDpvRJ03
        QgOca6qD0a2/ynsq4a1Vp6dpqnUk/bml5V72Xa4avGaaW2soJYfPie3zxj3ux1NAXX5MUN67O/b
        uSmNOWl20Z0ddWZP2tOoPcVFSms046EV6SmhV8qFG+9Ow3Skx9Zs=
X-Received: by 2002:a05:6402:51c9:b0:523:37cf:6f37 with SMTP id r9-20020a05640251c900b0052337cf6f37mr7551712edd.4.1695393624164;
        Fri, 22 Sep 2023 07:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaeMW0q3DuXsz0kHM9h9ZNaXKgZp/1aLg9254A9wa9TAeKK35Kd9zJ4ORdo4O86nq3u3AP7AmJn65V6xp8rOs=
X-Received: by 2002:a05:6402:51c9:b0:523:37cf:6f37 with SMTP id
 r9-20020a05640251c900b0052337cf6f37mr7551703edd.4.1695393623879; Fri, 22 Sep
 2023 07:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230922120040.15460-1-jtornosm@redhat.com> <b5fa2ea0-d025-47e3-a1c3-eb7c2f6bc5b7@quicinc.com>
In-Reply-To: <b5fa2ea0-d025-47e3-a1c3-eb7c2f6bc5b7@quicinc.com>
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Date:   Fri, 22 Sep 2023 16:40:12 +0200
Message-ID: <CABk-BGuOxCeHH0wJX9J3KBdn58nLDGnhWSn1Cma9R8AS2Xe_kQ@mail.gmail.com>
Subject: Re: [bug] mhi: ath11k: resume after hibernation is not working
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     kvalo@kernel.org, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Great!

Thanks for the info

Best regards
Jos=C3=A9 Ignacio

