Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30D47BFCEF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2019 03:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfI0Byx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 21:54:53 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44429 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbfI0Byw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 21:54:52 -0400
Received: by mail-lj1-f182.google.com with SMTP id m13so829498ljj.11
        for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2019 18:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jhAWj21SBU4jbqGG6MaZxUewlaN91DurSiSSGrn+ggg=;
        b=B594cMjSD9IwlaSHBEDs+Ejv6TVooshbEmg5tCqlTZOLb058VmGs3y1Bn6FmCdxiSl
         OAWf4UGRKsMNALNx86b8/8fbp0Bpyaq7D2Du6756MUf5PSyUWNCIhcg+Azq6GcAH6Wc0
         HFnDKsiTfoSKGv5kl01lsizPzRuBl3w1Rjjlamm63NYNAYaccdMCF8iyN6eWfmcV3lr8
         urQpdQ2M39ppuM505pX4ZPEhHSNUDkTOGwlobZtAIpsy0wE9mwzKVy98K7BoLmYF3W6C
         6WIFGaNxzareWId5Hk9EzHydSxlIS0cK2wvB2Aa8lsieo1t8kU+zq45lOl8wH3nR1YzL
         tK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jhAWj21SBU4jbqGG6MaZxUewlaN91DurSiSSGrn+ggg=;
        b=EEnqWKhm9i2S6kdYsfWF0KEcO0zI6dxIOXWo2OOpZcg5YlcCDpOU9Pj9j2YHl6PI1o
         LQFpzbivBwKQPCeHoBzxW8XT18j0crXLMKn7Na53szIyk1tyYj21tuOACB7jEtxWH9SG
         /cH7P4au1Ybqf7CC7aukoFL6eULHQPBpg/WCbjU+1qzlkYNr3Ff7sFTBOtOK/6CQeEPO
         /rzup3haWwYCv2S7Gb9cmk1bCdEW33O6eYwsirxCkF0MnNYQS59q8Iv8L3HshOnMazBk
         9llqDbDbaLH/lGx8Ne88OVDyIvcBFt7njCBoljpLMazE9SEg893u9Fnjv2j7crmZt2qY
         H9qA==
X-Gm-Message-State: APjAAAVv0VL92YWGZLUXQGReOPLUq1DpfWd9t6sNfpYdggpkYkXU6v8n
        A7QljfOm7P8jpymFE5CqC1fSPLXLwoOc42M6jtrVQc7P
X-Google-Smtp-Source: APXvYqz8J7yh1v5EsmasunNL0cHvCZmmJ7rz/WPVp3zUVA1H8OynpFApcD69jBXsw6hAHZlPmcRbkR9G9kL8oHKVBes=
X-Received: by 2002:a2e:b0c2:: with SMTP id g2mr950567ljl.217.1569549289202;
 Thu, 26 Sep 2019 18:54:49 -0700 (PDT)
MIME-Version: 1.0
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Thu, 26 Sep 2019 22:54:37 -0300
Message-ID: <CAK8U23ZyFnYt+ePreGjFA2VFXnpu21SPthscvJhP-5xjQCb0OA@mail.gmail.com>
Subject: mac80211_hwsim: packets being transmitted through the monitor interface
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I've noticed that packets transmitted between two clients connected to
a hostapd AP are also transmitted (injected) through the monitor
interface. Is this expected behavior? I can easily modify such
behavior by changing mac80211_hwsim, but it works only with hwsim0. On
the other hand, if I create a monitor interface via iw it doesn't
work.

--
Ramon Fontes
