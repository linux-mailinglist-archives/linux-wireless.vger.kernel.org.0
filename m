Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8AF1CC1F8
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgEIN7T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 May 2020 09:59:19 -0400
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:45566
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbgEIN7T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 May 2020 09:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589032758; bh=lhW4A2isBfUFOp8cdaqpq1JIhYMbbQMh9axpr5H73ho=; h=Date:From:Reply-To:Subject:References:From:Subject; b=cuHZBKyL4TQoaJYSbgmNW4yjdjxNCbYbMl/FWCTI5vddXpUaZ337ef8X7IdhaPNca7S03HUzT1oeRjEe+21V9CJtwX/0M/kUbHxEdJheX/NEUWupQhhYEnw1VFmIa9VLR/1lJiVTFJW3ge108XjcpQ9ro0+vhELw/SAPP1MYr1gPZzwYuZG5T0apN7zVYWA91LK7XSeMWV2449sgwQ4zoITnlOJ674o+b0RtBQpMY8m4yvmklyzvlZU+54zEOqUuslbeYpvTBNJqNccN81vWHxPKlzKSdoRwD2fufAx0yfedrLbu0LlGE9CLEvNwaEf7nDfmenxjprtUmI9UGU/iSg==
X-YMail-OSG: lmwlCk4VM1n7Jq7x4WmiexcmNGaJ5A_a89fo7tg6xFBefFqTaU1.TKzHkyrxFB8
 aySE_K.MIUcvfuXRPDqWwg20QIALNcuA.e7LG9Znr0C3PllsXXJWMl96WBuCjGSSj_oeT2LRr2di
 rPSMOCdXMkauqZE.B9KqmSQARigjmB.XQleuR.ixh7HAifRyAvHQDJWIpg.6d2jZKkAYtyuUcQRU
 29oTTBFdMwOibscJ3TsR8WM1K.XuKt.dkiF5j3m6rSjIuHd4XblqW23yKqXOseNiEvMG4uBzKekk
 uEErHCQf.qDWSdgt9axMX8_GMYwJ9vrUu0t2CqWzQuEpkLMxNxUXPRSyW4axOAdAcyOk.PenX91w
 BGP6DvSxHaa.f3yo4M7nsMDToHYqGpXn1t3ktaoRNfq2y0zUCfHPDzzUjxiLCKtU10zP.x.ud0GB
 5sRRjEOOSBVWExBXyexnH1aJE8REMuT3wpng8In_NEIAdwDQIpljWrn9LyVbTBvewjPcKNLmo6Os
 lLfPu27NqBJhmxIB53.J2Gcv5YpSUfMa35GTsR.eLltp7kzALEhewfiFUc3bgfW1vbIzE3JStQxe
 d22rdJwFZB5J.yGJC13hWDK2uMrAQkhLWcgc8A7koXHsbLklBTSNQHZCr_EzPPl0FaFLln9KtaPG
 a..c.jh3cXFsytvrZcwCd0Bh9K95Zc3sw2rlcF9V8XFH.zIifKIzeFyFVMxIv_hX6FV25d70zOMR
 kZobNqIX2oDtSveM9qNzfBRfcRIkVe_smmxCuW1aC5xVDKMNqDDnpwGoBxv1LMAIsGxZUzeTe1Hz
 8fpRGo_Ox8ungvIvm0HvWwB5ztXXCSMLNMCZXOHFnh2_aQMsppV5wzgMQkUdNsWp2kvxjBNK_45B
 21mofzfY6lz49t.F8Fc1HlC.tGYEx2LxsQLfBB3SV6wdqVbWy85YXEQomg6pqgvfwRgiSjf76V6M
 Jil6O8YpzQ4bh7LEqd6qUi1CErOB6NSvuhlPSSrxnNMU5H9oTTzX7OQNLiNRVp0DPmeyRiAp63Bx
 gErdYgcQZkn5Qur4crnbVfzHFFm._3KzPmktxScNrog64w.ZsqY2blj4C5SAkItYXVKspko84NRc
 vxBVuYXu3hUzkV4n3sUTXiNu3yp2En5VPKbYKEUHvbTE4MQ51mgI1_4Mq0izf4UlPDUxrPyWxDgV
 7FblkJD0AopFc8X21IUGLL2_W.NwCh4c3S5Vc2ST43k.aDGfVW1RkS9TM9k05hsyxZpB.RW5rJ97
 Wnb1kTvqfDluJGElThrQxg7DAMSYyx3N_ECAU8LoKW2A_43pwe9nSlasSiIt5r7w9ieclmmrCRuI
 KwHJQCA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Sat, 9 May 2020 13:59:18 +0000
Date:   Sat, 9 May 2020 13:59:18 +0000 (UTC)
From:   Pamela Render <prender2612@gmx.com>
Reply-To: prender508@gmail.com
Message-ID: <511297062.106894.1589032758047@mail.yahoo.com>
Subject: =?UTF-8?Q?Pros=C3=ADm,_hovor=C3=ADte_po_anglicky=3F?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <511297062.106894.1589032758047.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15904 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pros=C3=ADm, hovor=C3=ADte po anglicky?
