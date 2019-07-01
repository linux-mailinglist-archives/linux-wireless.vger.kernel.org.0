Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F795BB1F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfGAMCN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 08:02:13 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.209]:51166 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbfGAMCN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 08:02:13 -0400
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.us-west-2.aws.symcld.net id C2/8E-10808-246F91D5; Mon, 01 Jul 2019 12:02:10 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRWlGSWpSXmKPExsXi5LtOQNfpm2S
  swcuLWhZvVtxhd2D0+LxJLoAxijUzLym/IoE14/Gx86wFv6Urzq6MaWA8I93FyMUhJLCKUWLF
  gyXMEM5qRon5X7cxQTh7GCU2X7nH2MXIycEmoC9x880tdhBbRMBVYurGzcwgtrCArsTHXasZI
  eJGEt0z+1kgbD2Jla/msnYxcnCwCKhI/GyPBQnzCqhLfD3+B6yEUUBM4vupNUwgNrOAuMStJ/
  PBbAkBAYkle84zQ9iiEi8f/wMbIyoQLrG6wxwirCBxdNI6NpAws4CmxPpd+hCmuUTDbBmIgYo
  SU7ofskMsFZQ4OfMJ2FIhAWWJ0++3M05gFJ2FZO8shEGzEAbNQjJoFpJBCxhZVzGaJxVlpmeU
  5CZm5ugaGhjoGhoa6RoaW+qaGuklVukm65UW65anFpfoArnlxXrFlbnJOSl6eaklmxiBkZVS0
  G2yg/HCrDd6hxglOZiURHnnfpKMFeJLyk+pzEgszogvKs1JLT7EKMPBoSTBmw2SEyxKTU+tSM
  vMAUY5TFqCg0dJhLcCJM1bXJCYW5yZDpE6xWjMMeHl3EXMHEfmLl3ELMSSl5+XKiXOGwBSKgB
  SmlGaBzcIlnwuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmfQYyhSczrwRu3yugU5iATsmo
  EgM5pSQRISXVwDS7YGnUq/pE4bif7Lwzd5jwHrrleTXi2IrFkpnn7y1x8dSc1HxEsJ7F+pn30
  /j1idf2rJudcPd68rP/nwo8PswPE44QCdpcY5OTyGCX/XfmtjrzFV+PX3LMjy/NOT1946M3B2
  o++BSXbstIv/AvruHov2jRs9Kbp63J1+BYvCn3WF1pqDVH+iKG36J1Hi9PfDy9IrUvWSr+aDV
  3oNrXU3P6DUonv+xI40jgk3+7gy+t+eTiE+E1r7PSTgU0l/zVYdkpfN9Zi//skQ0LIoo1Gn7f
  /R1ZxqRvYPfBNGzOcqbE06FfZm4IE306VSZ4Y0rEkaNzHnYX3dl1fb3ewgvbJpbKn9LKsN13W
  UtTRO3+zx4lluKMREMt5qLiRADSy5cAuQMAAA==
X-Env-Sender: Isaac.Hermida@digi.com
X-Msg-Ref: server-3.tower-365.messagelabs.com!1561982529!741466!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32229 invoked from network); 1 Jul 2019 12:02:10 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-3.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Jul 2019 12:02:10 -0000
Received: from MTK-SMS-XCH04.digi.com (10.10.8.198) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 1 Jul 2019
 07:02:09 -0500
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MTK-SMS-XCH04.digi.com
 (10.10.8.198) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 1 Jul 2019
 07:02:08 -0500
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
 DOR-VMS-XCH01.digi.com ([fe80::c47f:be41:1dc7:5ab8%11]) with mapi id
 14.03.0439.000; Mon, 1 Jul 2019 14:02:07 +0200
From:   "Hermida, Isaac" <Isaac.Hermida@digi.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: ath10k-sdio: failed to load firmware
Thread-Topic: ath10k-sdio: failed to load firmware
Thread-Index: AQHVMATNLlwQ9chwvkqxami2KXYqtA==
Date:   Mon, 1 Jul 2019 12:02:06 +0000
Message-ID: <5D19F63D.8000302@digi.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
x-originating-ip: [10.101.2.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C30342D0FE01849A1E29EEF0D82FA92@digi.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgZ3V5cywNCg0KSSBrbm93IHRoYXQgaXQgaXMgc3RpbGwgdW5kZXIgZGV2ZWxvcG1lbnQsIGJ1
dCBJIGFtIHRyeWluZyB0byB1c2UgdGhlIGF0aDEwayBkcml2ZXIgd2l0aCBTRElPIHN1cHBvcnQg
b24gdGhlIFFDQTY1NzQgY2hpcC4gQXQgbGVhc3QsIGJhc2VkIG9uIGFsbCB0aGUgY29tbWl0cywg
SSBzaG91bGQgYmUgYWJsZSB0byBsb2FkIHRoZSBmaXJtd2FyZSBhbmQgaGF2ZSBhdCBsZWFzdCBh
IG1pbmltYWwgc3VwcG9ydCAoc3RhdGlvbiksIGJ1dCBjdXJyZW50bHkgSSBhbSB1bmFibGUgdG8g
bG9hZCB0aGUgRlcgY29ycmVjdGx5Lg0KDQpJIGFtIHVzaW5nIHRoZSBsYXRlc3QgImZpcm13YXJl
LXNkaW8tNi5iaW5fV0xBTi5STUguNC40LjEtMDAwMTEtUUNBUk1TV1AtMiIsIGJvYXJkLmJpbiBh
bmQgYm9hcmQtMi5iaW4gZnJvbSBbMV0uDQoiIiINCiMgbWQ1c3VtICoNCmRiODI2NGMzNTJmMjAy
ZjM4ZGZiOTkxNzUyMDkyNzRjICBib2FyZC0yLmJpbg0KY2IzN2M2M2Q5Y2EyOGY1M2ZlYTFmZjA5
YWQ3YzdhODIgIGJvYXJkLmJpbg0KMmUxOGU5YjE4NWUyZjVmMDk0MGNhMjZmOWY2MDhmNGEgIGZp
cm13YXJlLXNkaW8tNi5iaW4NCiIiIg0KDQpJIGFtIHVzaW5nIGFuIHVwc3RyZWFtIGtlcm5lbCAi
NS4xLjE0IiBhbmQgY29tbWl0ICIgYTc4OTFiMDI5OTA5MDA5ZmZhNGNkN2I2MjU5Mzk3OWYzZDkx
YWVmNyIgZnJvbSBbMl0uDQoNClRoZSBsb2FkIG9mIHRoZSBkcml2ZXIgZmFpbHMgYXM6DQoiIiIN
CiMgZG1lc2cgfCBncmVwIC1pRSAiYXRoMTBrfG1tYyINCjw0PmF0aDEwa19zZGlvIG1tYzA6MDAw
MToxOiBXQVJOSU5HOiBhdGgxMGsgU0RJTyBzdXBwb3J0IGlzIHdvcmstaW4tcHJvZ3Jlc3MsIHBy
b2JsZW1zIG1heSBhcmlzZSENCjw2PmF0aDEwa19zZGlvIG1tYzA6MDAwMToxOiBxY2E2MTc0IGh3
My4yIHNkaW8gdGFyZ2V0IDB4MDUwMzAwMDAgY2hpcF9pZCAweDAwMDAwMDAwIHN1YiAwMDAwOjAw
MDANCjw2PmF0aDEwa19zZGlvIG1tYzA6MDAwMToxOiBrY29uZmlnIGRlYnVnIDEgZGVidWdmcyAw
IHRyYWNpbmcgMCBkZnMgMCB0ZXN0bW9kZSAwDQo8Nj5hdGgxMGtfc2RpbyBtbWMwOjAwMDE6MTog
ZmlybXdhcmUgdmVyIFdMQU4uUk1ILjQuNC4xLTAwMDExLVFDQVJNU1dQLTIgYXBpIDYgZmVhdHVy
ZXMgd293bGFuLGlnbm9yZS1vdHAgY3JjMzIgNzI3ZTUwNDcNCjwzPmF0aDEwa19zZGlvIG1tYzA6
MDAwMToxOiBmYWlsZWQgdG8gZmV0Y2ggYm9hcmQgZGF0YSBmb3IgYnVzPXNkaW8sdmVuZG9yPTAy
NzEsZGV2aWNlPTA1MGEsc3Vic3lzdGVtLXZlbmRvcj0wMDAwLHN1YnN5c3RlbS1kZXZpY2U9MDAw
MCBmcm9tIGF0aDEway9RQ0E2MTc0L2h3My4wL2JvYXJkLTIuYmluDQo8Nj5hdGgxMGtfc2RpbyBt
bWMwOjAwMDE6MTogYm9hcmRfZmlsZSBhcGkgMSBibWlfaWQgTi9BIGNyYzMyIGVkNWY4NDlhDQo8
ND5hdGgxMGtfc2RpbyBtbWMwOjAwMDE6MTogdW5zdXBwb3J0ZWQgSFRDIHNlcnZpY2UgaWQ6IDE1
MzYNCjw2PmF0aDEwa19zZGlvIG1tYzA6MDAwMToxOiBodHQtdmVyIDMuNjAgd21pLW9wIDQgaHR0
LW9wIDMgY2FsIG90cCBtYXgtc3RhIDMyIHJhdyAwIGh3Y3J5cHRvIDENCjw0PmF0aDEwa19zZGlv
IG1tYzA6MDAwMToxOiBzdXNwZW5kIHRpbWVkIG91dCAtIHRhcmdldCBwYXVzZSBldmVudCBuZXZl
ciBjYW1lDQo8ND5tbWMwOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4MDEgKDMgYnl0ZXMp
DQo8ND5tbWMwOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4MWEgKDUgYnl0ZXMpDQo8ND5t
bWMwOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4MWIgKDggYnl0ZXMpDQo8ND5tbWMwOiBx
dWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4MTQgKDAgYnl0ZXMpDQo8ND5hdGgxMGtfc2RpbyBt
bWMwOjAwMDE6MTogdW5zdXBwb3J0ZWQgSFRDIHNlcnZpY2UgaWQ6IDE1MzYNCjw0PmF0aDEwa19z
ZGlvIG1tYzA6MDAwMToxOiB3bWkgY29tbWFuZCAxMzUxNjkgdGltZW91dCwgcmVzdGFydGluZyBo
YXJkd2FyZQ0KPDQ+YXRoMTBrX3NkaW8gbW1jMDowMDAxOjE6IGZhaWxlZCB0byBlbmFibGUgYWRh
cHRpdmUgcWNzOiAtMTENCjw0PmF0aDEwa19zZGlvIG1tYzA6MDAwMToxOiBjb3VsZCBub3Qgc3Vz
cGVuZCB0YXJnZXQgKC0xMDgpDQo8ND5tbWMwOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4
MDEgKDMgYnl0ZXMpDQo8ND5tbWMwOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4MWEgKDUg
Ynl0ZXMpDQo8ND5tbWMwOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4MWIgKDggYnl0ZXMp
DQo8ND5tbWMwOiBxdWV1aW5nIHVua25vd24gQ0lTIHR1cGxlIDB4MTQgKDAgYnl0ZXMpDQo8ND5h
dGgxMGtfc2RpbyBtbWMwOjAwMDE6MTogY2Fubm90IHJlc3RhcnQgYSBkZXZpY2UgdGhhdCBoYXNu
J3QgYmVlbiBzdGFydGVkDQoiIiINCg0KSSBhbSB1c2luZyB0aGUgY29ycmVjdCBGVyBmaWxlcz8g
SXMgYW55dGhpbmcgZWxzZSBuZWVkZWQsIG1heWJlIHJlbmFtZSBzb21lIGZpbGU/DQoNCg0KWzFd
IGh0dHBzOi8vZ2l0aHViLmNvbS9rdmFsby9hdGgxMGstZmlybXdhcmUvYmxvYi9tYXN0ZXIvUUNB
NjE3NC9odzMuMA0KWzJdIGh0dHBzOi8va2VybmVsLmdvb2dsZXNvdXJjZS5jb20vcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L2t2YWxvL2F0aA0K
