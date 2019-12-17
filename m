Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE1123AF9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 00:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfLQXhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 18:37:40 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:47091 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLQXhk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 18:37:40 -0500
Received: by mail-ot1-f41.google.com with SMTP id c22so7707otj.13
        for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2019 15:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/0x5LI6Cliq3r3WqRFVAa6MjVnvEl/FWbTVS8rks1Rc=;
        b=SSXE6m2UYNXz8kYy8zX/wy9u/yK2pRIZcSBDPuHAnGUKAfMcomJpHXRhIX+JfSPkxJ
         aZODGITphMVBoxlQ1H/WOsd3JOYKIJyK3Jw4AErx2vIFgi3y59BhLZCPuhH6oSki5i91
         7+DYf2U4MU3woXQoxIHCnY+efh7gAs5obWi3fapyWiL/ZY2cDffdOA/vaknooGNKAzkJ
         w1xwdo+a3eZhmDRrp/oMro53e+RIBNZgxNa2v7ChJmfKcgilll4JgHzCCdTkoxQdKE+B
         vmuCAI8xoSdfi9t68DopSx2yUGVSNwIQhgJD+6AqyjKDHMi0qB+vsnRyUN2b5BBSv5O3
         Zd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/0x5LI6Cliq3r3WqRFVAa6MjVnvEl/FWbTVS8rks1Rc=;
        b=Zw0TbAAN3slibR1YKH6XeyCoaDpT8yrT3EHJpEXKgwY4zEQPLmJbCHw3Q19Uynnwxv
         X0zBGZ49HRua0DBa+Ujwp21ZHuPdBfVX626H8h4CDSrAX1W3lDsxmpraVlacqYb91E4F
         08FPpzWt6kNBPDky3fiyqVOxoyPqx/W35nnwSeWB7yOH4NTP2i92tsGcoQQNNtElYg+j
         aq9dV57Asm8BlvmCY2HR/N5RQTBxKsnK1sA9XEqdmWQPmyTh4P7PRQscMOXPscUgu+rQ
         borvWZcXCfyOoilo5mrv0XgtFN4e9kg1xssWxl0G8omTbf/7mjOq6kakeOM6TT/3yK8U
         KyzA==
X-Gm-Message-State: APjAAAV/cvUhqcmVcinDRsKuNILFqWb5i27eKZrVlMsRfoRXA4H0Zvr3
        AvHUsN0qKGEEy34BJ/eXXggYFT3NK6PrbjP0pHA=
X-Google-Smtp-Source: APXvYqzNaLUQ/yA7iMcwgimKTSeMakiGiiIK1Ad9Mr21DmVINFZYCBr8EEuCo4o96Bok2xQ20QY4e2n369iwZuXVEpY=
X-Received: by 2002:a9d:7f16:: with SMTP id j22mr59798otq.256.1576625859483;
 Tue, 17 Dec 2019 15:37:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Tue, 17 Dec 2019 15:37:38 -0800 (PST)
In-Reply-To: <CAKR_QVL0P4qYidtqLwhhacCOpx2iq+4RRhTXbGhfRnf2PUj5tA@mail.gmail.com>
References: <20191216220747.887-1-greearb@candelatech.com> <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de> <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de> <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
 <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com> <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
 <a95e7f6d-1cb8-3188-aea4-233dce6f9330@candelatech.com> <CAKR_QVL0P4qYidtqLwhhacCOpx2iq+4RRhTXbGhfRnf2PUj5tA@mail.gmail.com>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Wed, 18 Dec 2019 00:37:38 +0100
Message-ID: <CAKR_QV+KV1dR_QKjANL34DGJuyf3OSN8J6gs3bqcmiRCCzkdXA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
To:     Ben Greear <greearb@candelatech.com>
Cc:     Justin Capella <justincapella@gmail.com>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

also noticed now that the noise floor changes with signal strength as
described in this bug report:
https://www.mail-archive.com/ath10k@lists.infradead.org/msg11553.html

after wifi restart

iwinfo:

signal: -59dBm noise: -108dBm

then goes to

signal: -52dBm noise: -103dBm

and finally drops to

signal: -59dBm noise: -103dBm
