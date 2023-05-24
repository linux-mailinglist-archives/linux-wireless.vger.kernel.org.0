Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F6B70F296
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 11:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240536AbjEXJWy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 05:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240674AbjEXJWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 05:22:48 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4447FE74
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 02:22:25 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 3f1490d57ef6-ba82059ef0bso655850276.1
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 02:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684920144; x=1687512144;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpy7HUUl9JUJVfHeyZRx3CTbUVGObKlyKlmgTELiasw=;
        b=rO2GCpdjmun/iHzG6gQ6eVnyzXqJSVKDuFFFDyJVpeBKr7jm+IbQfX4mCh2H+i9nnr
         QL3Hl5mkarr2KPzc1KC1RmJC1iVYIF8NV+llUi4yR7xD8ecwlpYjKhkPC968UIoB574C
         GjPl3GZ7lO5rKuQjwBxjt5sptk9ZgLUqrkXjmNiBB2MVF3qjRBZu7UxqrPFzA6BiqIby
         8ItbqvTpYPiI3iiF6SEOZfop6dgSZQyUbsH2D0zHfWJJX5VgqVex0e0haftdwS+htG3x
         73gt4TpkMCc7dR2de7Y1D4WRU1+jrohuECJDF26f1DAgd4l8KrPytle7iXtfUMN2295d
         qvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684920144; x=1687512144;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpy7HUUl9JUJVfHeyZRx3CTbUVGObKlyKlmgTELiasw=;
        b=iHdUGuf87UW02cNwTUgA5kX+84/++PH7Zw+WC8iHxanp9UqcBHJyRVvRB9y8LqtC6e
         Tjihyd/jCcwM3adbzC05SfSk6Qz2W/jCqJLoUpf2KuyDkpvm8576uIIh2Ymmq8rjoeoF
         i54rccreupHC+T7fCzf0D6j6yFlXxjb/c4K3CAy6jvtZpn2z3IO4HLcmnzLoCZ7d6CvD
         BCz94Zb/Cy4hN4vKb8sNVOLX5UcaWArNZ7QtZIzn0Z0NI0SR/077+QqzW+9JVsvyOCK2
         MuE5FL/Yn0DcnNvOmbW4TvLM18A7tvSyVVkVV1RWolNek94nH//xi8GJOKvYl4QirPck
         qUIw==
X-Gm-Message-State: AC+VfDwzIh0/fOXPX33jflo8+YaqVS6gweRax490tB1yw4g0bN5lcEuS
        nSnZk3ScrlheKfZ0Z1KU9hKn1B8ihElQLyvAPyU=
X-Google-Smtp-Source: ACHHUZ7mkZfe9kfHByEaLTUpKYvYYHrn4VSdO6pPb2YIA9I0+12zHZ4yZ7hXM2XVVloeWMijXpVS+wr1YQsw6ZmiXEs=
X-Received: by 2002:a25:f447:0:b0:b9a:7693:93f7 with SMTP id
 p7-20020a25f447000000b00b9a769393f7mr16532689ybe.45.1684920143691; Wed, 24
 May 2023 02:22:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:bb10:b0:4d0:8b23:c08c with HTTP; Wed, 24 May 2023
 02:22:23 -0700 (PDT)
Reply-To: philipsjohnsongoodp@gmail.com
From:   philips <robertandersongood7@gmail.com>
Date:   Wed, 24 May 2023 11:22:23 +0200
Message-ID: <CAE=WtcSJv2U88-tqY7YG5o_Q5Hebo2f_r2zvWVgkof3+1iMXew@mail.gmail.com>
Subject: good
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQrQnNC10L3RjyDQt9C+0LLRg9GCINCR0LDRgC7QpNC4
0LvQuNC/0YEg0JTQttC+0L3RgdC+0L0sINGPINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC0L3R
i9C5DQrQvNC10L3QtdC00LbQtdGAINC/0L4g0YDQsNCx0L7RgtC1INGBINC60LvQuNC10L3RgtCw
0LzQuCDQvNC+0LXQvNGDINC/0L7QutC+0LnQvdC+0LzRgyDQutC70LjQtdC90YLRgy4g0JIgMjAx
NyDQs9C+0LTRgw0K0LzQvtC5INC60LvQuNC10L3RgiDQv9C+INC40LzQtdC90LgNCtCc0LjRgdGC
0LXRgCDQmtCw0YDQu9C+0YEsINGPINGB0LLRj9C30LDQu9GB0Y8g0YEg0LLQsNC80Lgg0L/QviDR
gtC+0Lkg0L/RgNC40YfQuNC90LUsINGH0YLQviDQstGLDQrQvdC+0YHQuNGC0Ywg0L7QtNC90YMg
0YTQsNC80LjQu9C40Y4g0YEg0L/QvtC60L7QudC90YvQvCwg0Lgg0Y8g0LzQvtCz0YMg0L/RgNC1
0LTRgdGC0LDQstC40YLRjCDQstCw0YEg0LrQsNC6DQrQsdC10L3QtdGE0LjRhtC40LDRgCDQuCDQ
sdC70LjQttCw0LnRiNC40Lkg0YDQvtC00YHRgtCy0LXQvdC90LjQuiDRgdGA0LXQtNGB0YLQsiDQ
vNC+0LXQs9C+INC/0L7QutC+0LnQvdC+0LPQviDQutC70LjQtdC90YLQsCwg0YLQvtCz0LTQsCDQ
stGLDQrQstGL0YHRgtGD0L/QuNGC0Ywg0LIg0LrQsNGH0LXRgdGC0LLQtSDQtdCz0L4g0LHQu9C4
0LbQsNC50YjQtdCz0L4g0YDQvtC00YHRgtCy0LXQvdC90LjQutCwINC4INC/0L7RgtGA0LXQsdC+
0LLQsNGC0YwNCtGB0YDQtdC00YHRgtCy0LAuINC+0YHRgtCw0LLQu9GP0YLRjCDQvdCw0LvQuNGH
0L3Ri9C1DQrQvdCw0YHQu9C10LTRgdGC0LLQviDRgdC10LzQuCDQvNC40LvQu9C40L7QvdC+0LIg
0L/Rj9GC0LjRgdC+0YIg0YLRi9GB0Y/RhyDQodC+0LXQtNC40L3QtdC90L3Ri9GFINCo0YLQsNGC
0L7Qsg0K0JTQvtC70LvQsNGA0L7QsiAoNyA1MDAgMDAwLDAwINC00L7Qu9C70LDRgNC+0LIg0KHQ
qNCQKS4g0JzQvtC5INC/0L7QutC+0LnQvdGL0Lkg0LrQu9C40LXQvdGCINC4INC30LDQutCw0LTR
i9GH0L3Ri9C5DQrQtNGA0YPQsyDQstGL0YDQvtGBINCyDQrCq9CU0L7QvCDQsdC10Lcg0LzQsNGC
0LXRgNC4wrsuINCjINC90LXQs9C+INC90LUg0LHRi9C70L4g0L3QuCDRgdC10LzRjNC4LCDQvdC4
INCx0LXQvdC10YTQuNGG0LjQsNGA0LAsINC90Lgg0YHQu9C10LTRg9GO0YnQtdCz0L4NCtGA0L7Q
tNGB0YLQstC10L3QvdC40LrQvtCyINCyINC90LDRgdC70LXQtNGB0YLQstC+INCh0YDQtdC00YHR
gtCy0LAg0L7RgdGC0LDQstC70LXQvdGLINCyINCx0LDQvdC60LUuDQrQktGLINC00L7Qu9C20L3R
iyDRgdCy0Y/Qt9Cw0YLRjNGB0Y8g0YHQviDQvNC90L7QuSDRh9C10YDQtdC3INC80L7QuSDQu9C4
0YfQvdGL0Lkg0LDQtNGA0LXRgSDRjdC70LXQutGC0YDQvtC90L3QvtC5INC/0L7Rh9GC0Ys6DQpw
aGlsaXBzam9obnNvbmdvb2RwQGdtYWlsLmNvbQ0K0KEg0L3QsNC40LvRg9GH0YjQuNC80Lgg0L/Q
vtC20LXQu9Cw0L3QuNGP0LzQuCwNCtCR0LDRgC4g0KTQuNC70LjQv9GBINCU0LbQvtC90YHQvtC9
DQo=
